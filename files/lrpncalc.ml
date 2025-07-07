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


let compute tokens =
    let rec aux tk stack =
        match tk with
            | [] -> List.hd stack
            | (TKNum n) :: t -> aux t (n::stack)
            | (TKOp op) :: t -> try let n2 = List.hd stack in let n1 = List.hd (List.tl stack) in let s = List.tl (List.tl stack) in
                                    match op with
                                            | "+" -> aux t ((n1+n2)::s)
                                            | "x" -> aux t ((n1*n2)::s)
                                            | "-" -> aux t ((n1-n2)::s)
                                            | "/" -> aux t ((n1/n2)::s)
                                            | "mod" -> aux t ((n1 mod n2)::s)
                                            | _ -> failwith "Unknown operator"
                                with
                                    | _ -> failwith "Invalid RPN expression" in
  aux tokens [];;

(* TESTS *)
let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 -";;
let i_rpn_expr = expr_to_list "5 x 2 + -4 x + 3 -";;

compute rpn_expr;;
compute i_rpn_expr;;

let e = expr_to_list "5 2 3 + x" in compute e;;


(* conversion vers prefix et infix *)
let build_atree_from_rpn tokens =
  let rec aux tk stack =
    match tk with
      | [] -> List.hd stack
      | (TKNum n) :: t -> aux t ((Num n)::stack)
      | (TKOp op) :: t -> try let t1 = List.hd stack in 
                              let t2 = List.hd(List.tl stack) in 
                              let s = List.tl(List.tl stack) in
                              aux t (Node(op,t2,t1)::s)
                          with
                              | Stack.Empty -> failwith "Invalid RPN expression" in
  aux tokens [];;

let e = expr_to_list "5 2 3 + x" in build_atree_from_rpn e;;

(* Ambigu !*)
let rpn_to_infix tokens =
    let a = build_atree_from_rpn tokens in
    let rec infixe t =
        match t with
        | Num n -> [TKNum n]
        | Node (op, g, d) -> infixe g @ ((TKOp op) :: infixe d) in
    infixe a;;


let e = expr_to_list "5 2 3 + x" in rpn_to_infix e;;

(* Non ambigu *)
let prec node =
    match node with
        | Node("+",_,_) | Node("-",_,_) -> 1
        | Node("x",_,_) | Node("/",_,_) -> 2
        | _ -> 0;;


let rpn_to_infix tokens =
    let a = build_atree_from_rpn tokens in
    let rec infixe t =
        match t with
        | Num n -> [TKNum n]
        | Node (op, g, d) ->  let ppg  = (prec t > prec g) and  ppd = (prec t > prec d) in
            match g,d with
                | (Num _, Num _) -> (infixe g)@ ((TKOp op) :: (infixe d))
                | (Num n1, _)  -> [TKNum  n1] @ ((TKOp op) :: [TKOp "("]@infixe d@[ TKOp ")"])
                | (_, Num n2)  -> [TKOp "("]@ infixe g @[TKOp ")"] @ ((TKOp op) :: ([TKNum n2]))
                | (_,_) when ppg && ppd -> ([TKOp "("] @ (infixe g) @ [TKOp ")"]) @ ((TKOp op) ::  ([TKOp "("]@infixe d@[ TKOp ")"]))
                | (_,_) when ppg -> ([TKOp "("] @ (infixe g) @ [TKOp ")"]) @ ((TKOp op) ::  (infixe d))
                | (_,_) when ppd -> (infixe g) @ ((TKOp op) ::  ([TKOp "("]@infixe d@[ TKOp ")"]))
                | _ -> (infixe g)@ ((TKOp op) :: (infixe d)) in
    infixe a;;

let concat_tokens tokens =
    let rec aux acc tk =
        match tk with
        | [] -> acc
        | (TKNum n) :: t -> aux (acc ^ (string_of_int n))  t
        | (TKOp op) :: t -> aux (acc ^ op) t in
    aux "" tokens;;


let rpn_expr = expr_to_list "5 2 3 + x";;
rpn_to_infix rpn_expr;;
concat_tokens (rpn_to_infix rpn_expr);;


