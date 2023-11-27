open Graph

let clone_nodes gr = n_fold gr (fun g id -> new_node g id) empty_graph;;
  
let gmap gr f  =
  e_fold gr (fun acc arc -> new_arc acc { arc with lbl = f arc.lbl }) (clone_nodes gr);;

  let add_arc g id1 id2 n =
    let arc = { src = id1; tgt = id2; lbl = n } in
    try
      let existing_arc = match find_arc g id1 id2 with
        | Some a -> a
        | None -> raise Not_found
      in
      let updated_arc = { existing_arc with lbl = existing_arc.lbl + n } in
      new_arc g updated_arc
    with
    | Not_found -> new_arc g arc
  