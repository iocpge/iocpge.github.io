type operator = string;;
type token = TKOp of operator | TKNum of int;;
type atree = Num of int | Node of operator * atree * atree;;

let expr_to_list s =
    let tkl = String.split_on_char ' '  s in
    let rec filter tokens lst =
        match tokens with
        | [] -> lst
        | h::t -> match h with
                    | "+" -> filter t (TKOp "+" :: lst)
                    | "x" -> filter t (TKOp "x" :: lst)
                    | "-" -> filter t (TKOp "-" :: lst)
                    | "/" -> filter t (TKOp "/" :: lst)
                    | _ -> filter t ( TKNum (int_of_string h) ::  lst)
    in List.rev (filter tkl []);;


(* TESTS *)
let rpn_expr = expr_to_list "25 33 222 + x";;
let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 -";;
let rpn_expr = expr_to_list "5 1 2 + -4 x + 3 -";;

(* compute rpn_expr;; *)