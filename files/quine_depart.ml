type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or  of formule * formule  (* disjonction *)
  | Imp of formule * formule (* implication *)


let rec max_var f =
  match f with
  | T | F -> None
  | Var i -> Some i
  | Not fa -> max_var fa
  | And (fa, fb) | Or (fa, fb) | Imp (fa, fb) ->
      (match max_var fa, max_var fb with
       | None, None -> None
       | Some i, None -> Some i
       | None, Some j -> Some j
       | Some i, Some j -> Some (max i j));;

let nb_var f =
  match max_var f with
  | None -> 0
  | Some i -> i + 1;;


let s_not f =
  match f with
  | F -> T
  | T -> F
  | _ -> Not f;;

let s_and f1 f2 = (* TODO *) () ;;

let s_or f1 f2 = (* TODO *) () ;;

let s_imp f1 f2 =
    (* TODO *) () ;;

let rec simplify f = match f with
  | Var _ | T | F -> f
  | Not f1         -> s_not (simplify f1)
  | And(f1, f2)   -> s_and (simplify f1) (simplify f2)
  | Or(f1, f2)    -> s_or  (simplify f1) (simplify f2)
  | Imp(f1, f2)   -> s_imp (simplify f1)  (simplify f2);;

let rec subst k r f =
    match f with
      | F                -> F
      | T                -> T
      | Var j when k = j -> r
      | Var _            -> f
      | Not f            -> Not (subst k r f)
      | And(f1, f2)      -> And(subst k r f1, subst k r f2)
      | Or(f1, f2)       -> Or(subst k r f1, subst k r f2)
      | Imp(f1, f2)      -> Imp(subst k r f1, subst k r f2);;

let rec simple_quine_sat f = (* TODO *) ();;



let f1 = Or ((Var 0),  And ((Var 1),(Var 2)));;
simplify f1;;
subst 0 T f1;;
simplify (subst 0 T f1);;

let a = Imp(Var 0, Or(Var 1, Var 2));;
let b = Imp(Var 3, Or(Not (Var 2), Var 4));;
let c = Imp(Var 0, Var 3);;
let d = Imp(And(a,b), c);;
simple_quine_sat f1;;
simple_quine_sat d;;

let f2 = And ((Var 0),  And (Not (Var 0),(Var 1)));;
simple_quine_sat f2;;

let f3 = And ((Var 0),  Or (Not (Var 0),(Var 1)));;
