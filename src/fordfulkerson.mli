open Graph


(* Find a path from the current node to the destination node in the residual graph *)
val find_path : int graph -> id -> id -> int list ->  int arc list

(* Calculate the minimum increment along a path in the residual graph *)
val calcul_increment : int arc list -> int

(* Update the graph by augmenting the flow along the found path *)
val update : int graph -> int arc list -> int -> int graph

(* Find the final augmented graph from the source to the destination *)
val graph_final : int graph -> id -> id -> int graph

(* Convert the residual graph to the original graph with updated capacities *)
val graph_ecart_to_graph : id graph -> id graph -> id graph
