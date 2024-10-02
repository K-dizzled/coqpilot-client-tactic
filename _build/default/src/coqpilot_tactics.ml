let _ = Mltop.add_known_module "coqpilot.tactics-plugin"

# 3 "src/coqpilot_tactics.mlg"
 
  open Pp


let () = Vernacextend.static_vernac_extend ~plugin:(Some "coqpilot.tactics-plugin") ~command:"CallToC" ~classifier:(fun _ -> Vernacextend.classify_as_query) ?entry:None 
         [(Vernacextend.TyML (false, Vernacextend.TyTerminal ("Hello", 
                                     Vernacextend.TyNil), (let coqpp_body () = 
                                                          Vernactypes.vtdefault (fun () -> 
                                                          
# 8 "src/coqpilot_tactics.mlg"
                   
    Feedback.msg_notice (str Message.message)
  
                                                          ) in fun ?loc ~atts ()
                                                          -> coqpp_body (Attributes.unsupported_attributes atts)), None))]

