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


type 'a cell = { value : 'a ;
                 mutable before : 'a lst ;
                 mutable after : 'a lst}
      and 'a lst = Nil | Cell of 'a cell ;;

type 'a dequeue = { mutable head : 'a lst ;
                    mutable queue : 'a lst} ;;

let create_queue () = {head = Nil; queue = Nil};;

let enqueue e q =
    let c = Cell {value = e; before = q.queue; after = Nil} in
    match q.head, q.queue with
        | Nil, _ -> (q.head <- c ; q.queue <- Nil)
        | Cell h, Nil -> h.after <- c ; q.queue <- c
        | Cell _, Cell z -> z.after <- c; q.queue <- c;;


let dequeue q = match q.head with
    | Nil -> failwith "Empty Queue"
    | Cell c -> match c.after with
                    | Nil -> q.head <- Nil ; q.queue <- Nil ; c.value
                    | Cell d -> d.before <- Nil ; q.head <- c.after ; c.value ;;


type operator = string;;
type token = TKOp of operator | TKNum of int | TKOpenPar | TKClosingPar;;

let prec op =
    match op with
        | TKOp "+" | TKOp "-" -> 1
        | TKOp "x" | TKOp "/" -> 2
        | _ -> 0;;


let expr_to_list s =
    let tkl = String.split_on_char ' '  s in
    let rec filter tokens lst =
        match tokens with
        | [] -> lst
        | h::t -> match h with
                    | "(" -> filter t (TKOpenPar :: lst)
                    | ")" -> filter t (TKClosingPar :: lst)
                    | "+" -> filter t (TKOp "+" :: lst)
                    | "x" -> filter t (TKOp "x" :: lst)
                    | "-" -> filter t (TKOp "-" :: lst)
                    | "/" -> filter t (TKOp "/" :: lst)
                    | "mod" -> filter t (TKOp "mod" :: lst)
                    | _ -> filter t ( TKNum (int_of_string h) ::  lst)
    in List.rev (filter tkl []);;

let rec deq_to_list deq =
    let rec aux lst =
        match lst with
            | Nil -> []
            | Cell c -> c.value :: (aux c.after) in
    aux deq.head;;

let compute tokens =
    let s = Stack.create () in
    let rec aux tk =
        match tk with
            | [] -> ()
            | (TKNum n) :: t -> Stack.push n s; aux t
            | (TKOp op) :: t ->  try let n2 = Stack.pop s in let n1 = Stack.pop s in
                                    match op with
                                            | "+" -> Stack.push (n1 + n2) s; aux t
                                            | "x" -> Stack.push (n1 * n2) s; aux t
                                            | "-" -> Stack.push (n1 - n2) s; aux t
                                            | "/" -> Stack.push (n1 / n2) s; aux t
                                            | "mod" -> Stack.push (n1 mod n2) s; aux t
                                            | _ -> failwith "Unknown operator"
                                with
                                    | Stack.Empty -> failwith "Invalid RPN expression" in
    aux tokens;
    Stack.pop s;;

(* Implementation *)

let shunting_yard infix_expression = ();; (* TODO *)



(* TESTS  *)
(*let infix_expr = expr_to_list "( 5 + 1 ) x 2 + -4 x ( 3 - 7 )";;*)
(*let dq = shunting_yard "( 5 + 1 ) x 2 + -4 x ( 3 - 7 )";;*)
(*let rpn_expr = deq_to_list dq;;*)
(*compute rpn_expr;;*)


