open Graph
open Tools

(* -------------- find path -------------- *)
(*
  La fonction find_path cherche un chemin entre un sommet courant (current_id) 
  et un sommet de destination (id_dest) dans un graphe, en prenant en compte les 
  sommets déjà visités. Si le sommet courant est égal au sommet de destination, 
  la fonction renvoie une liste vide. Sinon, elle cherche un arc direct entre 
  le sommet courant et le sommet de destination. Si un tel arc est trouvé avec 
  une capacité (flow) positive, la fonction renvoie une liste contenant cet arc. 
  Sinon, elle explore les voisins du sommet couranten récursant sur la liste des arcs 
  sortants, en évitant les sommets déjà visités.La liste résultante représente un chemin augmentant dans le graphe.
*)
let rec find_path graph current_id id_dest visited =
  if current_id = id_dest then []
  else
    match find_arc graph current_id id_dest with
    | Some arc when arc.lbl > 0 -> [arc]
    | _ ->
        let out_arc_list = out_arcs graph current_id in
        let rec find_path_from_neighbors arcs =
          match arcs with
          | [] -> []
          | arc :: rest when not (List.mem arc.tgt visited) ->
              let path_to_dest = find_path graph arc.tgt id_dest (arc.tgt :: visited) in
              if arc.lbl > 0 && path_to_dest <> [] then arc :: path_to_dest
              else find_path_from_neighbors rest
          | _ :: rest -> find_path_from_neighbors rest
        in
        find_path_from_neighbors out_arc_list


(* -------------- calcul increment -------------- *)
(*
   calcul_increment qui renvoie le minimum des capacités résiduelles d'un path trouvé
   Si la liste est vide, on renvoie 0  Sinon, on renvoie le minimum des capacités 
   résiduelles des arcs de la liste, en utilisant fold_left
*)
let calcul_increment arc_list = match arc_list with
  | [] -> 0 
  | liste -> List.fold_left (fun accu x -> if x.lbl < accu then x.lbl else accu) max_int liste 
  

(* -------------- update -------------- *)
(*
La fonction update prend un graphe, une liste d'arcs, et une valeur en argument,
 puis ajuste les capacités du graphe en fonction de la valeur. Si la liste d'arcs 
 est vide, le graphe est renvoyé inchangé. Sinon, elle met à jour le graphe pour 
 l'arc qui avance en soustrayant la valeur de sa capacité résiduelle. Ensuite, elle 
 traite l'arc retour en vérifiant s'il existe un arc inverse dans le graphe mis à jour. 
 Si c'est le cas, et que sa capacité résiduelle est inférieure à la valeur, 
 elle ajoute un arc retour au graphe sinon ce n'est pas un arc retour mais un arc issu 
 d'une boucle !!!!! . Si aucun arc inverse n'est trouvé, elle en crée un.
La fonction s'appelle récursivement avec le graphe mis à jour et la suite de la liste d'arcs.
*)
let rec update graph arc_list value =
  match arc_list with
  | [] -> graph
  | arc::suite -> 
    let updated_graph_forward = add_arc graph arc.src arc.tgt (-value) in 
    let updated_graph_backward =   
      match find_arc updated_graph_forward arc.tgt arc.src with 
      | Some(existing_arc) -> 
       
        if existing_arc.lbl > value then
          updated_graph_forward
        else
          add_arc updated_graph_forward arc.tgt arc.src value
      | None -> 
        add_arc updated_graph_forward arc.tgt arc.src value 
    in
    update updated_graph_backward suite value 



(* -------------- graph_final -------------- *)
(* La fonction graph_final cherche et ajoute un chemin  entre un sommet source 
et un sommet puits dans un graphe. Si aucun chemin n'est trouvé, le graphe est renvoyé 
inchangé. Sinon, elle calcule l'incrément de flot avec calcul_increment et met à jour 
le graphe avec update, avant de s'appeler récursivement avec le graphe mis à jour et 
les mêmes sommets source et puits.
*)
let rec graph_final graph id_src id_dest =
  let arc_list = find_path graph id_src id_dest [] in 
    match arc_list with
      | [] -> graph
      | arc_list ->  
        let value = calcul_increment arc_list in 
          graph_final (update graph arc_list value) id_src id_dest



(* -------------- graph_ecart_to_graph -------------- *)
(*
  graph_ecart_to_graph qui applique une fonction de mappage sur le graphe initial
  à partir du graph final met à jour la capacité de chaque arc en la soustrayant 
  par la capacité correspondante dans le graphe d'écart ce qui donne le graph final
*)
let graph_ecart_to_graph graph_init graph_ecart = 
  let arc_to_ecart arc graph_ecart = match (find_arc graph_ecart arc.src arc.tgt) with 
    | None -> 0 
    | Some arc -> arc.lbl 
  in
  gmap graph_init (fun arc -> let updated_arc = {arc with lbl = arc.lbl - arc_to_ecart arc graph_ecart} in updated_arc) 
