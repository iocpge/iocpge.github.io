(* Stack implementation *)

type 'a stack = EmptyStack | Node of 'a * 'a stack

let empty () = EmptyStack;;

let is_empty s =
  match s with
  | EmptyStack -> true
  | Node (_, _) -> false;;

let push x s = Node (x, s)

let pop s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, s') -> (x, s');;

let peek s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, _) -> x;;


type operator = string;;
type token = TKOp of operator | TKNum of int;;

let expr_to_list s =
    let tkl = String.split_on_char ' '  s in
    let rec transtype tokens
        match tokens with
        | [] -> []
        | h::t -> match h with
                    | "+" ->  TKOp "+" :: transtype t
                    | "x" -> TKOp "x" :: transtype t
                    | "-" -> TKOp "-" :: transtype t
                    | "/" -> TKOp "/" :: transtype t
                    | _ -> TKNum (int_of_string h) ::  transtype t
    in transtype tkl;;

let expr_to_list s =
    let tkl = String.split_on_char ' '  s in
    let rec transtype token =
      match token with
        | "+" ->  TKOp "+"
        | "x" -> TKOp "x"
        | "-" -> TKOp "-"
        | "/" -> TKOp "/"
        | tk -> TKNum (int_of_string tk)
    in List.map transtype tkl;;

let compute expr =
    let tokens = expr_to_list expr in
    let rec aux tk stack =
        match tk with
            | [] -> let result, _ = pop stack in result
            | (TKNum n) :: t -> aux t (push n stack)
            | (TKOp op) :: t -> try let n2, st2 = pop stack in let n1, st =  pop st2 in
                                    match op with
                                            | "+" -> aux t (push (n1 + n2) st)
                                            | "x" -> aux t (push (n1 * n2) st)
                                            | "-" -> aux t (push (n1 - n2) st)
                                            | "/" -> aux t (push (n1 / n2) st)
                                            | "mod" -> aux t (push (n1 mod n2) st)
                                            | _ -> failwith "Unknown operator"
                                with
                                    | Failure "Empty Stack" -> failwith "Invalid RPN expression" in
    aux tokens EmptyStack;;



(* TESTS *)



let rpn_expr = expr_to_list "25 33 222 + x";;
let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 -";;
let rpn_expr = expr_to_list "5 1 2 + -4 x + 3 -";;

compute "7 3 2 + x";;
compute "5 1 2 + 4 x + 3 -";;
compute "5 1 2 + -4 x + 3 -";;
