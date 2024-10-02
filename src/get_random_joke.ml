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