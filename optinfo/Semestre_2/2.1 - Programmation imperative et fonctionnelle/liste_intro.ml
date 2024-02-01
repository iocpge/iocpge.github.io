
(* type liste inductive --> structure immuable *)
let l = [];;   (* liste vide *)
let l = [1;2;3];; (* type immuable *)
let l = 0 :: l;;  (* opérateur ajouter en tête *)

let  l = [true; false; true; true];;
let  l = [true; 0; true; true];; (* typage homogène de rigueur ! *)

(* fonctions du module List *)
let l = [1;3;5;7;9];;
List.hd l;;  (* tête de liste *)
List.tl l;;  (* queue de la liste *)
List.length l;; (* longueur de la liste *)

(* Exemple fondateur : somme des éléments d'une liste *)

let sum elements = (* itératif *)
    let acc = ref 0 in
    let lst = ref elements in
    while !lst != [] do
        let head = List.hd !lst in
        acc := !acc + head;
        lst := List.tl !lst;
    done;
    !acc;;

sum l;;

let rec sum elements = (* récursif *)
    if elements = []
    then 0
    else let head = List.hd elements in head + sum (List.tl elements);;

sum l;;

let rec sum elements = (* récursif et filtrage de motif d'une structure inductive *)
    match elements with
    | [] -> 0
    | head :: tail -> head + sum tail;;

sum l;;
