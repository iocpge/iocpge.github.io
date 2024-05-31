(* SHUNTING YARD
1.  Tant qu'il y a des lexèmes à lire :
2.        Lire un lexème
3.        Si c'est une nombre, l'enfiler dans la file
4.        Si c'est un opérateur op
5.               Tant que l'opérateur au sommet de la pile est plus prioritaire que op :
6.                       Dépiler cet opérateur et l'enfiler dans la file
7.               Empiler op sur la pile
8.        Si c'est une parenthèse ouvrante, l'empiler
9.        Si c'est une parenthèse fermante
10.            Tant que le sommet de la pile n'est pas une parenthèse ouvrante :
11.                     Dépiler l'opérateur et l'enfiler
12.            Dépiler la parenthèse ouvrante et l'ignorer
13. Tant que la pile d'opérateurs n'est pas vide, dépiler et enfiler les opérateurs.
*)


open Str  (* #load "str.cma";;  --> à exécuter dans l'interpréteur *)

type 'a stack = EmptyStack | Node of 'a * 'a stack

let empty () = EmptyStack;;

let is_empty s =
  match s with
  | EmptyStack -> true
  | Node (_, _) -> false;;

let push x s = Node (x, s);;

let pop s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, s') -> (x, s');;

let peek s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, _) -> x;;


type 'a file = {
  mutable front : 'a list;
  mutable back : 'a list;
}

let filevide () = { front = []; back = [] };;

let is_empty q = (q.front = [] && q.back = []);;

let enfiler x q = q.back <-  x :: q.back;;

let defiler q =
  let rec rev rlst lst =
    match lst with
    | [] -> rlst
    | h :: t -> rev (h::rlst) t in
  match q.front with
    | [] ->  ( match rev [] q.back with
                | [] -> failwith "Empty Queue Error"
                | e :: t -> q.front <- t; q.back <- []; e )
    | e :: t -> q.front <- t; e;;

let tete q =
  match q.front with
  | [] ->
      (match List.rev q.back with
       | [] -> None
       | x :: _ -> Some x)
  | x :: _ -> Some x;;


type operator = string;;
type token = TKOp of operator | TKNum of int | TKOpenPar | TKClosingPar;;

let op_priority op =
    match op with
        | TKOp "+" | TKOp "-" -> 1
        | TKOp "x" | TKOp "/" -> 2
        | TKOp _   | TKNum _ | TKOpenPar | TKClosingPar -> 0;;


let expr_to_list s =
    let tkl = split (regexp "[ \t]+") s in
    let rec transtype token  =
        match token with
                    | "(" -> TKOpenPar
                    | ")" -> TKClosingPar
                    | "+" -> TKOp "+"
                    | "x" -> TKOp "x"
                    | "-" -> TKOp "-"
                    | "/" -> TKOp "/"
                    | "mod" -> TKOp "mod"
                    | _ -> TKNum (int_of_string token) in
    List.map transtype tkl;;

(* transformer une file en liste *)
let rec q_to_list q = [];; (* TODO *)

(* Implementation *)

let shunting_yard infix_expression =
    let expr = expr_to_list infix_expression
    and q = filevide () in
    let rec aux tokens op_stack = (* TODO *)
       match tokens with
        | [] -> op_stack
        | TKOpenPar::t -> print_string "("; aux t EmptyStack
        | TKClosingPar::t -> print_string ")"; aux t EmptyStack
        | (TKNum n)::t -> print_int n; aux t EmptyStack
        | (TKOp op)::t -> print_string op;  aux t EmptyStack
    in let op_stack = aux expr EmptyStack in
    let rec empty_op_stack stack =
        match stack with
        | EmptyStack -> ()
        | Node(op, st) -> enfiler op q; empty_op_stack st in
    try empty_op_stack op_stack; q_to_list q with
    | Failure _ -> q_to_list q;;


let compute expr =
    let tokens = shunting_yard expr in
    let rec aux tk stack =
        match tk with
            | [] -> let result, _ = pop stack in result
            | (TKNum n) :: t -> aux t (push n stack)
            | (TKOp op) :: t -> ( try let n2, st2 = pop stack in let n1, st =  pop st2 in
                                    match op with
                                            | "+" -> aux t (push (n1 + n2) st)
                                            | "x" -> aux t (push (n1 * n2) st)
                                            | "-" -> aux t (push (n1 - n2) st)
                                            | "/" -> aux t (push (n1 / n2) st)
                                            | "mod" -> aux t (push (n1 mod n2) st)
                                            | _ -> failwith "Unknown operator"
                                with
                                    | Failure _ -> failwith "RPN Syntax Error" )
             | TKOpenPar :: _ | TKClosingPar :: _ -> failwith "RPN Syntax Error"
in
    aux tokens EmptyStack;;

(* TESTS  *)
let infix_expr = expr_to_list " ( 5 + 1  ) x 2 - 4 x (  3 - 7 )";;
let rpn_expr = shunting_yard " ( 5 + 1  ) x 2 - 4 x (  3 - 7 )";;
compute " ( 5 + 1  ) x 2 - 4 x (  3 - 7 )";;


