open Graph
open Tools


(*
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
*)

(* CYCLES !!!!*)

let rec find_path graph current_id id_dest visited =
  if current_id = id_dest then []
  else
    match find_arc graph current_id id_dest with
    | Some arc when arc.lbl > 0 -> [arc]
    | _ ->
        let out_arc_list = out_arcs graph current_id in
        let rec find_path_from_neighbors arcs =
          match arcs with
          | [] -> []
          | arc :: rest when not (List.mem arc.tgt visited) ->
              let path_to_dest = find_path graph arc.tgt id_dest (arc.tgt :: visited) in
              if arc.lbl > 0 && path_to_dest <> [] then arc :: path_to_dest
              else find_path_from_neighbors rest
          | _ :: rest -> find_path_from_neighbors rest
        in
        find_path_from_neighbors out_arc_list


let calcul_decrement arc_list = match arc_list with
  | [] -> 0
  | liste -> List.fold_left (fun accu x -> if x.lbl < accu then x.lbl else accu) max_int liste


let rec update graph arc_list value = 
  match arc_list with
  | [] -> graph
  | arc::suite -> let updated_graph_forward = add_arc graph arc.src arc.tgt (-value) in 
    let updated_graph_backward = add_arc updated_graph_forward arc.tgt arc.src value in 
      update updated_graph_backward suite value


let rec graph_final graph id_src id_dest =
  let arc_list = find_path graph id_src id_dest [] in 
    match arc_list with
      | [] -> graph
      | arc_list ->  
        let value = calcul_decrement arc_list in 
          graph_final (update graph arc_list value) id_src id_dest

          
