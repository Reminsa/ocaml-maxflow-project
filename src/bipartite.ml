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














(*Add_person_id prend une liste et une ligne et lit la personne qui se trouve sur cette ligne *)
let get_list_of_candidates list line =
  try 
    Scanf.sscanf line "candidate %d" (fun id -> List.append list [id]) 
  with _e ->
    Printf.printf "Impossible to read candidate in line : \n%s\n" line ; 
    failwith "from_file"  


(*Get_list_of_people retourne la liste des personnes dans un graph *)
let get_list_of_people file =
  let open_file = open_in file in 
  let init_list = [] in 

  let rec loop list =
    try
      let line = input_line open_file in 
      let line = String.trim line in
      let list_aux = 
        if line = "" then list
        else match line.[0] with 
          | 'c' -> get_list_of_candidates list line
          | _ -> list
      in
      loop list_aux
    with End_of_file -> list 
  in
  let out = loop init_list in
  close_in open_file ;
  out


(*is_candidate vérifie si l'id donnée est une id de personne*)
let rec is_candidate id = function 
  | [] -> false 
  | x :: rest -> if (x==id) then true else (is_candidate id rest)

(*Solution_found donne le texte qui va être affiché  *)
let solution_found = fun id1 id2 _lbl _list ->
  if (id1=origine) then "Candidate " ^ (string_of_int id2) ^ " -> No School \n"
  else if (id2=destination) then "School " ^ (string_of_int id1) ^ " -> No Candidate \n"
  else "Candidate " ^ (string_of_int id2) ^ " -> School " ^ (string_of_int id1) ^ " \n"


(*Aux affiche la solution *)
let aux file graph people_list =
  let out = open_out file in 
  Printf.fprintf out "Which candidate will get which school ?\n";

  e_iter graph (fun arc ->
    if arc.lbl <> 0 && arc.tgt <> origine && arc.src <> destination && not (is_candidate arc.src people_list) then
      Printf.fprintf out "%s\n" (solution_found arc.src arc.tgt arc.lbl people_list)
  );

  close_out out;
  ()

(*school_to_candidate est la fonction principale*)
let school_to_candidate infile graph_fin outfile = 
  let people = get_list_of_people infile in 
    aux outfile graph_fin people 