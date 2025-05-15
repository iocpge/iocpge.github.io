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
let rec mem x t = () (* TODO *)

mem 3 a_test
mem 42 a_test


(* Insérer un type comparable dans l'arbre *)
let rec insert e t = () (* TODO *)


insert 42 a_test 
insert 0 a_test 


(* Construire un arbre à partir d'une liste *)

let abr_of_list lst =  () (* TODO *)

affiche_abr (abr_of_list liste_test)



(* Parcours infixe pour récupérer les éléments de l'arbre en ordre croissant *)
let rec infixe t = () (* TODO *)

infixe a_test

(* Trier une liste en utilisant un ABR *)
let trier l =  () (* TODO *)

trier liste_test

(* Équilibrer un arbre (Complexité ?) *)
let balance t = () (* TODO *)

let liste = [9;8;7;6;5;4;3;2;1] in affiche_abr  (abr_of_list liste)

let liste = [9;8;7;6;5;4;3;2;1] in affiche_abr (balance (abr_of_list liste))


(* Trouver le minimum d'un arbre avec exception *)
let rec min_elem t = () (* TODO *)

min_elem (abr_of_list [9;8;7;6;5;4;3;2;1])

min_elem Vide

(* Trouver le minimum d'un arbre avec type option *)
let rec min_elem t = () (* TODO *)

min_elem (abr_of_list [9;8;7;6;5;4;3;2;1])
min_elem Vide

(* Retirer le minimum d'un arbre avec exception *)
let rec remove_min_elem t = () (* TODO *)

remove_min_elem a_test

(* Fusionner deux arbres dont les éléments sont plus petits à gauche tg < td *)
let merge tg td = () (* TODO *)

(* Supprimer un élément de l'arbre avec gestion des erreurs *)
let rec remove e t = () (* TODO *)

remove 3 a_test
