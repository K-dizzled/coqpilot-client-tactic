val get_random_joke : 
    unit -> 
    (string, string) result

val start_server : 
    unit -> 
    (Yojson.Basic.t, string) result Lwt.t

val retrieve_text_from_server :
    unit -> 
    (string, string) result