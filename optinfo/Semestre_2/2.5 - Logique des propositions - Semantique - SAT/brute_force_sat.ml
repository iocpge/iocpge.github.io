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

let get_var_k_from_v v k = Int.logand v (Int.shift_left 1 k) != 0;;

let rec evaluation v f =
    match f with
        | T -> true
        | F -> false
        | Var k -> get_var_k_from_v v k
        | Not p -> not (evaluation v p)
        | And (p, q) -> evaluation v p && evaluation v q
        | Or (p, q) -> evaluation v p || evaluation v q
        | Imp (p, q) -> not (evaluation v p) || (evaluation v q);;

let brute_force_satisfiability f =
  let n = nb_var f in
  (* n est le nombre de variables propositionnelles de type int de 0 à n-1 *)
  let v_limit = Int.shift_left 1 n in
  (* v_limit = 2^n est la première valuation impossible *)
    let rec check_val valuation =
        match valuation with
            | v when v < v_limit -> if evaluation v f
                                    then true
                                    else check_val (v + 1)
            | _ -> false (* condition d'arrêt de la récursivité *)
    in check_val 0;;


let opt_brute_force_satisfiability f =
  let n = nb_var f in
  (* n est le nombre de variables propositionnelles de type int de 0 à n-1 *)
  let v_limit = Int.shift_left 1 n in
  (* v_limit = 2^n est la première valuation impossible *)
    let rec check_val valuation =
        match valuation with
            | v when v < v_limit -> if evaluation v f
                                    then Some v
                                    else check_val (v + 1)
            | _ -> None (* condition d'arrêt de la récursivité *)
    in check_val 0;;

(* MAIN *)

let f1 = Or ((Var 0),  And ((Var 1),(Var 2)))

let f2 = Or (And ((Var 0),(Not (Var 1))), And ((Var 1), Not(Or ((Var 2),(Var 0)))))

let f3 = Or (Or (And (Not (Var 0) , (Var 1)),  (Var 3)), And ((Var 2), Not(Or((Var 1), (Var 3)))))

let f4 =
     let p1 = Var 0
         and p2 = Or (Var 1, Not(Var 2))
         and s1 = And(Not(Var 0), Not(Var 1))
         and s2 = Or (Var 1, And( Not (Var 0), Not (Var 2)))
     in let p = Or ( And (p1, p2), And(Not p1, Not p2) )
            and s = Or (And(s1, s2), And(Not s1, Not s2) )
     in And (p, s);;


brute_force_satisfiability f1;;
brute_force_satisfiability f2;;
brute_force_satisfiability f3;;
brute_force_satisfiability f4;;

let f5 = And (And (And (Not (Var 0) , (Var 1)),  (Var 2)), And ((Var 0), Not(Or((Var 1), (Var 2)))));;
brute_force_satisfiability f5;;

let f6 = And(And(Or(f4,f5), Or(Not(f5), f2)), Or(Imp(f4,f3), And(f3, Not(f1))));;
brute_force_satisfiability f6;;




