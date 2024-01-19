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
    | And (fa,fb) -> max_var fb (max_var fa k)
    | Or  (fa,fb) -> max_var fb (max_var fa k)
    | Imp (fa,fb) -> max_var fb (max_var fa k)

let s_not f =
    match f with
        | F -> T
        | T -> F
        | _ -> Not f

let s_and f1 f2 =
    match (f1, f2) with
        | F,_ | _,F -> F
        | T,f | f,T -> f
        | _,_       -> And (f1,f2)

let s_or f1 f2 =
    match (f1, f2) with
        | T,_ | _, T -> T
        | F,f | f, F -> f
        | _,_        -> Or (f1,f2)

let s_imp f1 f2 =
    match (f1, f2) with
        | F,_  -> T (* ex falso quodlibet *)
        | _,T  -> T
        | T, f -> f
        | f, F -> s_not f
        | _,_  -> Imp (f1,f2)

let rec simplify f = match f with
  | Var _ | T | F -> f
  | Not f1         -> s_not (simplify f1)
  | And(f1, f2)   -> s_and (simplify f1) (simplify f2)
  | Or(f1, f2)    -> s_or  (simplify f1) (simplify f2)
  | Imp(f1, f2)   -> s_imp (simplify f1)  (simplify f2)

let rec subst k r f =
    match f with
      | F                -> F
      | T                -> T
      | Var j when k = j -> r
      | Var _            -> f
      | Not f            -> Not (subst k r f)
      | And(f1, f2)      -> And(subst k r f1, subst k r f2)
      | Or(f1, f2)       -> Or(subst k r f1, subst k r f2)
      | Imp(f1, f2)      -> Imp(subst k r f1, subst k r f2)

let rec simple_quine_sat f =
  match simplify f with
      | T -> true
      | F -> false
      | f -> let v = max_var f 0 in simple_quine_sat (subst v T f) || simple_quine_sat (subst v F f);;


let rec quine_sat f valuation =
  match simplify f with
      | T -> List.iter (fun (v,b) -> Printf.printf "%d,%d \t" v b) valuation; print_newline(); true
      | F -> false
      | f -> let v = max_var f 0 in quine_sat (subst v T f) ((v,1)::valuation) || quine_sat (subst v F f) ((v,0)::valuation);;

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
quine_sat f1 [];;
quine_sat d [];;

let f2 = And ((Var 0),  And (Not (Var 0),(Var 2)));;
simple_quine_sat f2;;

