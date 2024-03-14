type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or  of formule * formule  (* disjonction *)
  | Imp of formule * formule (* implication *)

let rec max_var f k = (* k is current index *)
    match f with
    | T | F -> k
    | Var i -> max i k
    | Not fa -> max_var fa k
    | And (fa,fb) | Or  (fa,fb) | Imp (fa,fb) -> max_var fb (max_var fa k);;


(* SMART CONSTRUCTORS *)
let s_not f =
    match f with
        | F -> T
        | T -> F
        | _ -> Not f;;

let s_and f1 f2 = (); (* TODO *)

let s_or f1 f2 = (); (* TODO *)

let s_imp f1 f2 = (); (* TODO *)

(* Appliquer les simplications et les smart constructors *)
let rec simplify f = (); (* TODO *)


(* substituer dans une formule logique *)
let rec subst k r f = (); (* TODO *)

(* SAT ? RENVOYER TRUE OU FALSE *)
let rec simple_quine_sat f = (); (* TODO *)

(* SAT ? RENVOYER LA VALUATION POUR LAQUELLE f EST VRAIE OU NONE *)
let rec quine_sat f  = (); (* TODO *)


(* TESTS *)