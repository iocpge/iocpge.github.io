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
    let s = Stack.create () in
    let rec aux tk =
        match tk with
            | [] -> ()
            | (TKNum n) :: t -> Stack.push n s; aux t
            | (TKOp op) :: t ->   try let n2 = Stack.pop s in let n1 = Stack.pop s in
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


(* conversion vers prefix et infix *)
let build_atree_from_rpn tokens =
    let s = Stack.create () in
    let rec aux tk =
        match tk with
            | [] -> ()
            | (TKNum n) :: t -> Stack.push (Num n) s; aux t
            | (TKOp op) :: t -> try let t1 = Stack.pop s in let t2 = Stack.pop s in
                                    Stack.push (Node(op, t2, t1)) s; aux t
                                with
                                    | Stack.Empty -> failwith "Invalid RPN expression" in
    aux tokens;
    Stack.pop s;;

let rpn_to_prefix tokens =
    let a = build_atree_from_rpn tokens in
    let rec prefixe a =
        match a with
        | Num n -> [TKNum n]
        | Node (e, fg, fd) -> (TKOp e) :: (prefixe fg @ prefixe fd)  in
    prefixe a;;


(* ne marche pas car ambigüe ! *)
let rpn_to_infix tokens =
    let a = build_atree_from_rpn tokens in
    let rec infixe t =
        match t with
        | Num n -> [TKNum n]
        | Node (op, g, d) -> infixe g @ ((TKOp op) :: infixe d) in
    infixe a;;

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

(* Shunting yard algorithm *)
(* Evaluation of a infix expression through RPN calculator using stack*)

let shunting_yard infix_expr =
    let op = Stack.create () in
    let rpn = Queue.create () in



(* TESTS *)
let rpn_expr = expr_to_list "25 33 222 + x";;
let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 -";;
let rpn_expr = expr_to_list "5 1 2 + -4 x + 3 -";;
(*let rpn_expr = expr_to_list "5 1 2 + 4 x + 3 mod";;*)
let i_rpn_expr = expr_to_list "5 x 2 + -4 x + 3 -";;

compute rpn_expr;;
compute i_rpn_expr;;


build_atree_from_rpn rpn_expr;;
rpn_to_prefix rpn_expr;;

rpn_to_infix rpn_expr;;
concat_tokens (rpn_to_infix rpn_expr);;


