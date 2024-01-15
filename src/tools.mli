open Graph

(* Clone the nodes of the input graph, creating a new graph of a potentially different type. *)
val clone_nodes: 'a graph -> 'b graph

(* Map a function over the arcs of the input graph, producing a new graph of a potentially different type. *)
val gmap: 'a graph -> ('a arc -> 'b arc) -> 'b graph

(* Add an arc with the given source, target, and label to the input graph. If an arc between the source and target already exists, update its label. *)
val add_arc: int graph -> id -> id -> int -> int graph