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
