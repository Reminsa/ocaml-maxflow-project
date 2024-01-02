open Graph 
open Tools

(*Noeud origine*)
let origine = 0
(*Noeud destination*)
let destination = (-1)

(* Fonction pour créer une instance de nœud origine *)
(* let create_origine_node graph capacity = new_node graph capacity


(* Fonction pour créer une instance de nœud de destination *)
let create_destination_node  graph capacity = new_node graph capacity *)

(* 1) Créer un réseau de flux *)

let create_each_edge_from_the_origine graph line = 
  try 
    Scanf.sscanf line "candidate %d" (fun candidate -> add_arc (new_node graph candidate) origine candidate 1) 
  with _e ->
    Printf.printf "Impossible to create the candiate in line : \n%s\n" line ; 
    failwith "from_file"


let create_each_edge_from_the_destination graph line =
  try 
    Scanf.sscanf line "school %d" (fun school -> add_arc (new_node graph school) school destination 1) 
  with _e ->
    Printf.printf "Impossible to integrate the school : \n%s\n" line ; 
    failwith "from_file"


let candidate_integrate_school graph line = 
      try 
        Scanf.sscanf line "wish %d %d" (fun candidate school -> add_arc graph candidate school 1) 
      with _e ->
        Printf.printf "Impossible to integrate the school in line : \n%s\n" line ; 
        failwith "from_file"

(* comment identified = un commentaire pour simplement l'ignorer*)
let comment graph line =
  try
    Scanf.sscanf line "%%" graph
  with _ ->
    Printf.printf "Unknown line : \n%s\n" line ; 
    failwith "from_file"

(*Read_file utilise les fonctions précedemment définies pour créer le graphe sur lequel on appliquera l'algorithme Ford Fulkerson*)
let read_file file =
  let open_file = open_in file in 
  let init_graph = new_node (new_node empty_graph origine) destination in

  (*Boucle lisant toutes les lignes du fichier*)
  let rec loop graph =
    try
      let line = input_line open_file in 
      (* On enlève les espaces*)
      let line = String.trim line in
      let graph_inter = 
        (* On ignore les lignes où il n'y a pas de texte*)
        if line = "" then graph

        else match line.[0] with 
         (*c pour candidat*) | 'c' -> create_each_edge_from_the_origine graph line
         (*s pour school*)  | 's' -> create_each_edge_from_the_destination graph line
          (*w pour wish *)| 'w' -> candidate_integrate_school graph line
          (* le reste on l'ignore par exemple les commentaires *)| _ -> comment graph line
      in
      loop graph_inter

    with End_of_file -> graph 
  in
  let out = loop init_graph in
  close_in open_file ;
  out

