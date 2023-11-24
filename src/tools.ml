open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)



let clone_nodes gr = n_fold gr (fun g id -> new_node g id) empty_graph;;

(*let gmap gr f =   e_iter gr (fun x -> f x ) ;;*)

(*let gmap gr f =  e_fold gr (fun g arc -> e_iter gr (fun x -> f x)) empty_graph ;;*)
  
let gmap gr f  =
  e_fold gr (fun acc arc -> new_arc acc { arc with lbl = f arc.lbl }) (clone_nodes gr);;

let add_arc _graph _id1 _id2 _x = assert false  
