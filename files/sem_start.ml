type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or of formule * formule  (* disjonction *)
  | Imp of formule * formule;;

let rec max_var f k = (* k is current index *)
    match f with
    | T | F -> k
    | Var i -> max i k
    | Not fa -> max_var fa k
    | And (fa,fb) | Or  (fa,fb) | Imp (fa,fb) -> max_var fb (max_var fa k);;

let nb_var f = (max_var f 0) + 1;;