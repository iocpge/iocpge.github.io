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

let s_not f =
    match f with
        | F -> T
        | T -> F
        | _ -> Not f;;

let s_and f1 f2 =
    match f1, f2 with
        | F,_ | _,F -> F
        | T,f | f,T -> f
        | _,_       -> And (f1,f2);;

let s_or f1 f2 =
    match (f1, f2) with
        | T,_ | _, T -> T
        | F,f | f, F -> f
        | _,_        -> Or (f1,f2);;

let s_imp f1 f2 = F;; (* TODO *)

let rec simplify f = match f with
  | Var _ | T | F -> f
  | Not f1         -> s_not (simplify f1)
  | And(f1, f2)   -> s_and (simplify f1) (simplify f2)
  | Or(f1, f2)    -> s_or  (simplify f1) (simplify f2)
  | Imp(f1, f2)   -> s_imp (simplify f1)  (simplify f2);;

let rec subst k r f = F;; (* TODO *)

let rec quine_sat f =
  match simplify f with
      | T -> true
      | F -> false
      | sf -> let v = max_var sf 0 in
        quine_sat (subst v T sf) || quine_sat (subst v F sf);;


let f1 = Or ((Var 0),  And ((Var 1),(Var 2)));;
simplify f1;;
subst 0 T f1;;
simplify (subst 0 T f1);;
quine_sat f1;;

let a = Imp(Var 0, Or(Var 1, Var 2));;
let b = Imp(Var 3, Or(Not (Var 2), Var 4));;
let c = Imp(Var 0, Var 3);;
let d = Imp(And(a,b), c);;
simplify d;;
subst 0 T d;;
simplify (subst 3 T d);;
simplify (subst 3 F (subst 1 T d));;
simplify (subst 2 F (subst 1 F d));;

quine_sat d;;

