open Graph

(*Type of label of an arc, with a couple of flow & cost*)
type label = int * int

(* Type of a path from a node to another node
 * A path is represented by a list of (id,id,label) *)
type path = (id * id * label ) list    



(*find path g s d : finds in the graph a path from soucre_node to destination_node having min cost 
 *@raise Graphe_error if s (ou d) is unknown in the graph *)
val find_path_mincost : label graph -> id -> id -> path

(*print_path path  : print this path in terminal*)
val print_path : path -> unit

(* val find_path : (id * 'a) graph -> id -> id -> id list -> (id * 'a) arc list *)

(* Update the graph by augmenting the flow along the found path *)
val update : (int*int)  graph -> path -> int ->  (int*int) graph


(* Find the final augmented graph from the source to the destination *)
val graph_final_bell : (int*int) graph -> id -> id -> (int*int) graph


(* Calculate the minimum increment along a path in the residual graph *)
val calcul_increment : path -> int
