open Gfile
open Tools
open FordFulkerson
open Graph
    


	let () =

		let rec display_arc_list (arc_list) =
			match arc_list with
			| [] -> ()
			| arc::[] -> Printf.printf "%d\n%d\n" arc.src arc.tgt
			| arc::suite -> Printf.printf "%d\n" arc.src; display_arc_list suite
		in		


	(* Check the number of command-line arguments *)
  	if Array.length Sys.argv <> 6 then
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
  
  (* These command-line arguments are not used for the moment. *)
	and _source = int_of_string Sys.argv.(2)
  	and _sink = int_of_string Sys.argv.(3)
 	in

 	(* Open file *)
  	let graph = from_file infile in (*Génère un string graph*)

 	(*let graph = clone_nodes graph in (*Clone le graph sans arcs*)*)

	let graph = gmap graph (fun x -> int_of_string x) in (*transforme de string graph en int graph*)

	let graph = add_arc graph 0 5 100 in (*On modifie/rajoute un arc*)

	let () = display_arc_list (find_path graph 3 5) in

	let () = Printf.printf "%d\n" (calcul_increment (find_path graph 3 5)) in
	
	let graph = gmap graph (fun x -> string_of_int x) in (* On retransforme en string graph pour le truc d'après*)

  	(* Rewrite the graph that has been read. *)
  	let () = write_file outfile graph in

	let () = export outfiledot graph in


  	()

