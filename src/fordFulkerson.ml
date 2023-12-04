open Graph



let rec find_path graph id_src id_dest =
  if id_src = id_dest then []
  else
    match find_arc graph id_src id_dest with
    | Some arc -> [arc]
    | None ->
        let out_arc_list = out_arcs graph id_src in
        let rec find_path_from_neighbors arcs =
          match arcs with
          | [] -> []
          | arc :: rest ->
              match find_path graph arc.tgt id_dest with
              | [] -> find_path_from_neighbors rest
              | path -> arc :: path
        in
        find_path_from_neighbors out_arc_list




let calcul_increment arc_list = List.fold_left (fun accu x -> if x.lbl < accu then x.lbl else accu) max_int arc_list;;




(* prolog :
 
arc(Src, Dest).
path(X, X).
path(Orig, Dest) :-
    arc(Orig, X),
    path(X, Dest).

*)