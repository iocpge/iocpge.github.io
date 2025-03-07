type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or of formule * formule;;  (* disjonction *)

let valuation i = match i with
  | 0 -> true  (* a valuation *)
  | 1 -> false (* b valuation *)
  | 2 -> true  (* c valuation *) 
  | _ -> failwith "Unknown variable !"

let rec evaluation v f =
    match f with
        | T -> true
        | F -> false
        | Var x -> v x
        | Not p -> not (evaluation v p)
        | And (p, q) -> evaluation v p && evaluation v q
        | Or (p, q) -> evaluation v p || evaluation v q

let rec taille f =
  match f with
  | T -> 0
  | F -> 0
  | Var _ -> 0
  | Not f -> 1 + (taille f)
  | And (fa,fb) -> 1 + (taille fa) + (taille fb)
  | Or (fa,fb) -> 1 + (taille fa) + (taille fb)

let rec hauteur f =
  match f with
  | T -> 0
  | F -> 0
  | Var _ -> 0
  | Not f -> 1 + (hauteur f)
  | And (fa,fb) -> 1 + (max (hauteur fa) (hauteur fb))
  | Or (fa,fb) -> 1 + (max (hauteur fa) (hauteur fb))

let rec max_var f k = (* k is current index *)
    match f with
    | T | F -> k
    | Var i -> max i k
    | Not fa -> max_var fa k
    | And (fa,fb) -> max_var fb (max_var fa k)
    | Or  (fa,fb) -> max_var fb (max_var fa k)

let nb_var f = (max_var f 0) + 1


(* MAIN *)

let f1 = Or ((Var 0),  And ((Var 1),(Var 2)));;
let f2 = Or (And ((Var 0),(Not (Var 1))), And ((Var 1), Not(Or ((Var 2),(Var 0)))));;
let f3 = Or (Not(Var 0), (Var 1));;
let f4 = And ((Var 0), And (Or(Not (Var 1), (Var 2)), Or(Not (Var 2), (Var 1))));;

evaluation valuation f1;;
evaluation valuation f2;;
evaluation valuation f3;;
evaluation valuation f4;;

taille f1;;
taille f2;;
taille f3;;
taille f4;;

hauteur f1;;
hauteur f2;;
hauteur f3;;
hauteur f4;;

max_var f1;;
max_var f2;;
max_var f3;;
max_var f4;;

nb_var f1;;
nb_var f2;;
nb_var f3;;
nb_var f4;;

