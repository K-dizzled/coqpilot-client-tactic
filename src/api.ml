open Lwt
open Cohttp
open Cohttp_lwt_unix
open Yojson.Basic.Util

let fetch_joke () =
  let headers = Header.init_with "Accept" "application/json" in
  Client.get ~headers (Uri.of_string "https://icanhazdadjoke.com/") >>= fun (resp, body) ->
  let code = resp |> Response.status |> Code.code_of_status in
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  if code = 200 then 
    Ok body 
  else 
    Error (Printf.sprintf "Failed with status code: %d" code)

let get_random_joke () =
  match Lwt_main.run (fetch_joke ()) with
  | Ok body ->
      let json = Yojson.Basic.from_string body in
      let joke = json |> member "joke" |> to_string in
      Ok joke
  | Error msg ->
      Error msg

let timeout_duration = 5.0

let start_server () =
  let stop_server, stopper = Lwt.wait () in
  let received_body = ref None in

  let callback _conn req body =
    body |> Cohttp_lwt.Body.to_string >|= fun body_str ->
    received_body := Some body_str;
    (* Signal to stop the server *)
    Lwt.wakeup stopper ();
    (* Return the response status and body *)
    `OK, Cohttp_lwt.Body.of_string "Request received. Server stopping."
  in

  let wrapped_callback conn req body =
    callback conn req body >>= fun (status, body) ->
    Server.respond ~status ~body ~headers:(Header.init ()) ()
  in

  let server =
    Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback:wrapped_callback ())
  in

  let timeout_promise = 
    Lwt_unix.sleep timeout_duration >>= fun () -> Lwt.return (
      Error (Printf.sprintf "No response from server received in %f seconds" timeout_duration)
    ) 
  in

  let result =
    Lwt.pick [server; stop_server] >>= fun () ->
    match !received_body with
    | Some body ->
        (try
            let json = Yojson.Basic.from_string body in
            Lwt.return (Ok json)
          with Yojson.Json_error msg ->
            Lwt.return (Error ("Failed to parse JSON: " ^ msg)))
    | None -> Lwt.return (Error "No request received")
  in

  Lwt.pick [result; timeout_promise]

let retrieve_text_from_server () =
  match Lwt_main.run (start_server ()) with
    | Ok json ->
        let text = json |> member "text" |> to_string in
        Ok text
    | Error msg ->
        Error (msg)