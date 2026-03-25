type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or of formule * formule  (* disjonction *)
  | Imp of formule * formule;;


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
       | Some i, Some j -> Some (max i j))

let nb_var f =
  match max_var f with
  | None -> 0
  | Some i -> i + 1

let get_var_k_from_v v k =  v land (1 lsl k) != 0;;

let rec evaluation v f =
    match f with
        | T -> true
        | F -> false
        | Var k -> get_var_k_from_v v k
        | Not p -> not (evaluation v p)
        | And (p, q) -> evaluation v p && evaluation v q
        | Or (p, q) -> evaluation v p || evaluation v q
        | Imp (p, q) -> not (evaluation v p) || (evaluation v q);;

let brute f = ()
  (* TODO *) ;;



(* MAIN *)

let f1 = Or ((Var 0),  And ((Var 1),(Var 2)));;

let f2 = Or (And ((Var 0),(Not (Var 1))), And ((Var 1), Not(Or ((Var 2),(Var 0)))));;

let f3 = Or (Or (And (Not (Var 0) , (Var 1)),  (Var 3)), And ((Var 2), Not(Or((Var 1), (Var 3)))));;

let f4 =
     let p1 = Var 0
         and p2 = Or (Var 1, Not(Var 2))
         and s1 = And(Not(Var 0), Not(Var 1))
         and s2 = Or (Var 1, And( Not (Var 0), Not (Var 2)))
     in let p = Or ( And (p1, p2), And(Not p1, Not p2) )
            and s = Or (And(s1, s2), And(Not s1, Not s2) )
     in And (p, s);;

brute f4;;


let f5 = And (And (And (Not (Var 0) , (Var 1)),  (Var 2)), And ((Var 0), Not(Or((Var 1), (Var 2)))));;
brute f5;;

let f6 = And(And(Or(f4,f5), Or(Not(f5), f2)), Or(Imp(f4,f3), And(f3, Not(f1))));;
brute f6;;




