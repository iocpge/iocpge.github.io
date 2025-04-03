(* Type pour les arbres binaires de recherche *)
type 'a abr = Vide | Noeud of 'a * 'a abr * 'a abr

let a_test =
   Noeud(5,
        Noeud(3,
          Noeud(1, Vide, Vide),
          Noeud(4, Vide, Vide)),
        Noeud(8,
          Noeud(6, Vide, Vide),
          Noeud(9, Vide, Vide))
        )

let liste_test = [23;19;21;17]

(* Afficher de une ABR d'entiers *)
let affiche_abr a =
  let rec aux chaine t =
    match t with
    | Vide -> print_string (chaine ^ "├── Vide\n")
    | Noeud(x, g, d) ->
        print_string (chaine ^ "├── " ^ string_of_int x ^ "\n");
        aux (chaine ^ "│   ") d;
        aux (chaine ^ "│   ") g
  in
  aux "" a;
  print_newline ()

affiche_abr a_test

(* Calculer la hauteur d'un arbre *)
let rec hauteur t =
  match t with
  | Vide -> -1
  | Noeud(_, g, d) -> 1 + max (hauteur g) (hauteur d)

hauteur a_test

(* Calculer la taille d'un arbre (nombre de noeuds) *)
let rec taille t =
  match t with
  | Vide -> 0
  | Noeud(_, g, d) -> 1 + taille g + taille d

taille a_test

(* Fonction pour vérifier si un élément est présent dans l'arbre *)
let rec mem x t =
  match t with
  | Vide -> false
  | Noeud(e, g, d) -> 
      if x = e then true
        else if x < e then mem x g
        else mem x d

mem 3 a_test
mem 42 a_test


(* Insérer un type comparable dans l'arbre *)
let rec insert e t =
  match t with
  | Vide -> Noeud(e, Vide, Vide)
  | Noeud(x, g, d) ->
      if e <= x then Noeud(x, insert e g, d)
      else Noeud(x, g, insert e d)


insert 42 a_test 
insert 0 a_test 


(* Construire un arbre à partir d'une liste *)

let abr_of_list lst = 
  let rec build l a = 
    match l with
    | [] -> a
    | e :: t -> build t (insert e a)
  in build lst Vide 

affiche_abr (abr_of_list liste_test)

let abr_of_list l =  List.fold_left (fun acc e -> insert e acc) Vide l

affiche_abr (abr_of_list liste_test)


(* Parcours infixe pour récupérer les éléments de l'arbre en ordre croissant *)
let rec infixe t =
  match t with
  | Vide -> []
  | Noeud(x, g, d) -> infixe g @ [x] @ infixe d

infixe a_test

(* Trier une liste en utilisant un ABR *)
let trier l =  infixe (abr_of_list l)

trier liste_test

(* Équilibrer un arbre (Complexité ?) *)
let balance t =
  let inorder = infixe t in
  let rec build lst debut fin =
    if debut > fin then Vide
    else
      let m  = (debut + fin) / 2 in
      let e = List.nth lst m in
      Noeud(e, 
            build lst debut (m - 1),
            build lst (m + 1) fin)
    in build inorder 0 (List.length inorder - 1)

let liste = [9;8;7;6;5;4;3;2;1] in affiche_abr  (abr_of_list liste)

let liste = [9;8;7;6;5;4;3;2;1] in affiche_abr (balance (abr_of_list liste))


(* Trouver le minimum d'un arbre avec exception *)
let rec min_elem t =
  match t with
  | Vide -> failwith "No minimum"
  | Noeud(e, Vide, _) -> e
  | Noeud(_, g, _) -> min_elem g

min_elem (abr_of_list [9;8;7;6;5;4;3;2;1])

min_elem Vide

(* Trouver le minimum d'un arbre avec type option *)
let rec min_elem t =
  match t with
  | Vide -> None
  | Noeud(e, Vide, _) -> Some e
  | Noeud(_, g, _) -> min_elem g

min_elem (abr_of_list [9;8;7;6;5;4;3;2;1])
min_elem Vide

(* Retirer le minimum d'un arbre avec exception *)
let rec remove_min_elem t =
  match t  with
  | Vide -> failwith "No minimum"
  | Noeud(_, Vide, d) -> d
  | Noeud(e, g, d) -> Noeud(e, remove_min_elem g, d)

remove_min_elem a_test

(* Fusionner deux arbres dont les éléments sont plus petits à gauche tg < td *)
let merge tg td =
  match tg, td with
  | Vide, t | t, Vide -> t
  | g, d -> Noeud(min_elem d, g, remove_min_elem d)

(* Supprimer un élément de l'arbre avec gestion des erreurs *)
let rec remove e t =
  match t with
  | Vide -> failwith "Nothing to remove"
  | Noeud(x,g,d) when x = e -> merge g d
  | Noeud(x,g,d) when e < x -> Noeud(x, remove e g, d)
  | Noeud(x,g,d) -> Noeud(x,g,remove e d);;

remove 3 a_test
