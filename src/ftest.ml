open Gfile
open Tools
open Graph
open Fordfulkerson
open Bipartite
open GCostfile
open Bellmanford



	let () =

	(* Check the number of command-line arguments *)
  	if Array.length Sys.argv <> 12 then
    	begin
			Printf.printf
				"\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
				("    🟄  infile  : input file containing a graph\n" ^
				"    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
				"    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
				"    🟄  outfile : output file in which the result should be written.\n\n") ;
			exit 0
    	end ;


  	(* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  	let infile = Sys.argv.(1)
  	and outfile = Sys.argv.(4)
		and outfiledot = Sys.argv.(5)
		and infile_bip = Sys.argv.(6)
		and outfile_biparti = Sys.argv.(7)
  	and outfiledot_biparti = Sys.argv.(8)
		and outfile_solution = Sys.argv.(9)
		and infile_BF = Sys.argv.(10)
		(* and outfiledot_BF = Sys.argv.(11) *)

  (* These command-line arguments are not used for the moment. *)
	and _source = int_of_string Sys.argv.(2)
  	and _sink = int_of_string Sys.argv.(3)
 	in

	(* -----------------sessions Bellman Ford -------------------------- *)
  let graph_BellFord = from_file_cost infile_BF in (*Génère un string graph*)
	
	
	 let result_path = find_path_mincost graph_BellFord 0 5 in  

	 let () = print_path result_path in
	
	



	(* let result_path = find_path_mincost int_int_graph_Bellford 0 5 in 
	
	let () = print_path result_path in *)

 	(* Open file *)
  let graph = from_file infile in (*Génère un string graph*)

 	(*let graph = clone_nodes graph in (*Clone le graph sans arcs*)*)

	let graph = gmap graph (fun arc -> let updated_arc = {arc with lbl = int_of_string arc.lbl} in updated_arc) in (*transforme de string graph en int graph*)

	(*let graph = add_arc graph 0 5 100 in (*On modifie/rajoute un arc*)*)

	let graph = graph_final graph 0 5 in
	
	let graph = gmap graph (fun arc -> let updated_arc = {arc with lbl = string_of_int arc.lbl} in updated_arc) in (* On retransforme en string graph pour le truc d'après*)

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

	let () = export outfiledot graph in


	(* Read_file test and export initial graph *)
	let graph_bip = read_file infile_bip in (* crée un int graph depuis parcoursup_data.txt *)
	let graph_bip = graph_final graph_bip 0 (-1) in
	let graph_bip = gmap graph_bip (fun arc -> let updated_arc = {arc with lbl = string_of_int arc.lbl} in updated_arc) in (* On retransforme en string graph pour le truc d'après*)
  let () = write_file outfile_biparti graph_bip in
  let () = export outfiledot_biparti graph_bip  in
	let graph_bip = gmap graph_bip (fun arc -> let updated_arc = {arc with lbl = int_of_string arc.lbl} in updated_arc) in
 	let () = school_to_candidate infile graph_bip outfile_solution in


	
	
	()