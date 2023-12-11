open Graph
open Tools



let rec find_path graph id_src id_dest =
  if id_src = id_dest then []
  else
    match find_arc graph id_src id_dest with
    | Some arc -> if arc.lbl > 0 then [arc] else []  
    | None ->
        let out_arc_list = out_arcs graph id_src in
        let rec find_path_from_neighbors arcs =
          match arcs with
          | [] -> []
          | arc :: rest ->
              match find_path graph arc.tgt id_dest with
              | [] -> find_path_from_neighbors rest
              | path -> if arc.lbl > 0 then arc::path else find_path_from_neighbors rest
        in
        find_path_from_neighbors out_arc_list


(* CYCLES !!!!*)

let calcul_decrement arc_list = match arc_list with
  | [] -> 0
  | liste -> List.fold_left (fun accu x -> if x.lbl < accu then x.lbl else accu) max_int liste

let decrement_arc_in_path arc decrement = let updated_arc = { arc with lbl = arc.lbl - decrement } in updated_arc

let rec decrease_decrement graph arc_list decrement = 
  match arc_list with
  | [] -> graph
  | arc::suite -> decrease_decrement (new_arc (add_arc graph arc.tgt arc.src (-decrement)) (decrement_arc_in_path arc decrement)) suite decrement 


let rec graph_final graph id_src id_dest =
  let arc_list = find_path graph id_src id_dest in 
    match arc_list with
      | [] -> graph
      | arc_list ->  
        let value_decrement = calcul_decrement arc_list in 
          graph_final (decrease_decrement graph arc_list value_decrement) id_src id_dest

