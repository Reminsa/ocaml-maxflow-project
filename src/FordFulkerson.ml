open Graph

let rec find_path graph id_src id_dest = 
  if id_src == id_dest then [] else
  match find_arc graph id_src id_dest with
  | Some arc -> arc
  | None -> let l_arc = out_arcs graph id_src  in
  List.iter (fun x -> find_path graph ) l_arc

    







(* prolog :
 
arc(Src, Dest).
path(X, X).
path(Orig, Dest) :-
    arc(Orig, X),
    path(X, Dest).

*)