open Graph

type label = int * int

type  path = (id * id * label) list  



(*This function finds a list which includes all of paths from a to b *)
let rec list_path g from_a marked b= match from_a with
	| [] -> assert false
	| (_x,y,_l)::_tl -> 
		if y=b then [from_a] 
		else	
			let newmarked = y :: marked in
			let n = List.filter (fun arc -> not (List.mem arc.tgt newmarked) ) (out_arcs g y) in
			List.concat ( List.map (fun arc -> list_path g ( (y,arc.tgt,arc.lbl)::from_a) newmarked b ) n)


(*This function returns the cost of a path*)
let find_cost path = List.fold_left (fun acu (_,_,(_,cost)) -> acu + cost) 0 path

(*This function returns a correct ordre path from a to b which having the min cost*)
let find_path_mincost g s d =
	if not (node_exists g s) then raise (Graph_error ("Node " ^ string_of_int(s) ^ " does not exists in the graph."))
	else if not (node_exists g d) then raise (Graph_error ("Node " ^ string_of_int(d) ^ " does not exists in the graph."))
	else
		assert (s<>d);
		(*Reverse the path, easier to verify the result*)
		let pathlist = list_path g [(s,s,(0,0))] [s]  d in 
		let rec loop min path = function	
			| [] -> path
			| p :: tl -> if find_cost p < min then loop (find_cost p) p tl else loop min path tl
		in match List.rev (loop 10000 [] pathlist) with
			| [] -> []
			| _a :: tl -> tl


(*-----------------------------------------------------------------------
This function returns the value of flow_min from path, this value is used to update the graph
------------------------------------------------------------------------*)
let find_flow_min path = List.fold_left (fun min (_,_,(flow,_)) -> if flow < min then flow else min) 10000 path 
			
(*-----------------------------------------------------------------------
val print_path : (id * id * label) list -> unit
This function prints the path, helps to check the results (path,flow_min)
------------------------------------------------------------------------*)
let print_path path = 
	Printf.printf "{ ";
	List.iter (fun (id1,id2,_) -> Printf.printf "(%d,%d) " id1 id2 ) (path);
	Printf.printf " -> min flow = %d & cost = %d" (find_flow_min path) (find_cost path);
	Printf.printf " }\n"




(* let rec find_path graph current_id id_dest visited =
		if current_id = id_dest then []
		else
			let out_arc_list = out_arcs graph current_id in
			let rec find_path_from_neighbors arcs =
				match arcs with
				| [] -> []
				| arc :: rest when not (List.mem arc.tgt visited) ->
						let path_to_dest = find_path graph arc.tgt id_dest (arc.tgt :: visited) in
						if fst arc.lbl > 0 && path_to_dest <> [] then arc :: path_to_dest
						else find_path_from_neighbors rest
				| _ :: rest -> find_path_from_neighbors rest
			in
			find_path_from_neighbors out_arc_list *)




let calcul_increment arc_list =
				match arc_list with
				| [] -> 0 
				| liste -> List.fold_left (fun accu (_, _, (flow, _)) -> min flow accu) max_int liste


let update_arc g id1 id2 (flow, cost) =
				let arc = { src = id1; tgt = id2; lbl = (flow, cost) } in
				try
					let existing_arc = match find_arc g id1 id2 with
						| Some a -> a
						| None -> raise Not_found
					in
					let updated_arc = { existing_arc with lbl = (fst existing_arc.lbl + flow, snd existing_arc.lbl + cost) } in
					new_arc g updated_arc
				with
				| Not_found -> new_arc g arc



let rec update graph arc_list value =
				match arc_list with
				| [] -> graph
				| _arc ::suite -> 
					let updated_graph_forward =  match arc_list with 
						| [] -> graph
						| (a,b,( _flow,cost)):: _rest -> 
							(* update updated_graph_backward suite value  *)
						
						update_arc graph a b (-value,cost) in 
					
					
					
					
					let updated_graph_backward =  match arc_list with 
						|	[] ->  graph
						|	(a,b,(_flow,cost))::_rest ->  match find_arc updated_graph_forward b a with 
												| Some(existing_arc) -> 
						 
													if fst existing_arc.lbl > value then
														updated_graph_forward
													else
														update_arc updated_graph_forward b a (value , cost)
												| None -> 
													update_arc updated_graph_forward b a (value , 0 - cost)
					in
					update updated_graph_backward suite value 
			

let rec graph_final_bell graph id_src id_dest =
						let arc_list = find_path_mincost graph id_src id_dest in 
							match arc_list with
								| [] -> graph
								| arc_list ->  
									let value = calcul_increment arc_list in 
										graph_final_bell (update graph arc_list value) id_src id_dest
					