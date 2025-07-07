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
                    | "mod" -> filter t (TKOp "mod" :: lst)
                    | _ -> filter t ( TKNum (int_of_string h) ::  lst)
    in List.rev (filter tkl []);;

(* TESTS *)
let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 -";;
let i_rpn_expr = expr_to_list "5 x 2 + -4 x + 3 -";;

let compute tokens = ();;
  
compute rpn_expr;;
compute i_rpn_expr;;

let e = expr_to_list "5 2 3 + x" in compute e;;


(* conversion vers prefix et infix *)
let build_atree_from_rpn tokens = ();; (* TODO *)

let e = expr_to_list "5 2 3 + x" in build_atree_from_rpn e;;  (* TODO *)

let rpn_to_infix tokens = ();;  (* TODO *)

let e = expr_to_list "5 2 3 + x" in rpn_to_infix e;;  (* TODO *)



