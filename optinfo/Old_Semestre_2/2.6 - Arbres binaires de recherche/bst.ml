type 'a bst = Empty | Node of 'a * 'a bst * 'a bst;;

let rec mem x t =
  match t with
  | Empty -> false
  | Node(e,g,d) -> Printf.printf "%d\n" e;
                   if x < e
                   then mem x g
                   else if x > e
                        then mem x d
                        else true;;


let rec insert e t =
  match t with
  | Empty -> Node(e, Empty, Empty)
  | Node(x,g,d) -> if e <= x
                   then Node(x, insert e g, d)
                   else Node(x, g, insert e d);;

let rec min_elem t =
  match t with
  | Empty -> failwith "No minimum in an empty tree !"
  | Node(e, Empty, _) -> e
  | Node(e,g,d) -> min_elem g;;
;;

(*let rec min_elem t =
  match t with
  | Empty -> None
  | Node(e, Empty, _) -> Some e
  | Node(e,g,d) -> min_elem g;;
 *)

let rec remove_min_elem t =
  match t  with
  | Empty -> failwith "No minimum in an empty tree !"
  | Node(_,Empty, d) -> d
  | Node(e, g,d) -> Node(e, remove_min_elem g, d)
;;

let merge t_inf t_sup =
  match t_inf, t_sup with
  | Empty, t | t, Empty -> t
  | g, d -> Node(min_elem d, g, remove_min_elem d);;

let rec remove e t =
  match t with
  | Empty -> failwith "Nothing to remove from an empty tree !"
  | Node(x,g,d) when x = e -> merge g d
  | Node(x,g,d) when e < x -> Node(x, remove e g, d)
  | Node(x,g,d) -> Node(x,g,remove e d);;
  ;;


(* TESTS *)
let a = Node(5,
             Node(3,
                  Node(1, Empty, Empty),
                  Node(4, Empty, Empty)),
             Node(8,
                  Node(6,Empty, Empty),
                  Node(9,Empty, Empty))
          );;

mem 6 a;;
insert 10 a;;
insert 7 a;;
min_elem Empty;;

try min_elem Empty with
| Failure "No minimum in an empty tree !" ->  3
| _ -> 0;;

min_elem a;;


let t0 = Empty;;
let t1 =  insert 50 t0;;
let t2 =  insert 17 t1;;
let t3 =  insert 72 t2;;
let t4 =  insert 0 t3;;
let t5 =  insert 11 t4;;
let t6 =  insert 87 t5;;
let t7 =  insert 23 t6;;
let t8 =  insert 66 t7;;
let t9 =  insert 33 t8;;
let t10 = insert 99 t9;;
let t = insert 47 t10;;


mem 47 t;;
mem 48 t;;
mem 66 t;;
mem 98 t;;

min_elem t;;
let tm = remove_min_elem t;;

let t10 =  insert 11 t0;;
let t20 =  insert 15 t10;;
let t30 =  insert 19 t20;;
let t40 =  insert 4 t30;;
let t50 =  insert 7 t40;;

let t100 =  insert 33 t0;;
let t200 =  insert 37 t100;;
let t300 =  insert 46 t200;;
let t400 =  insert 23 t300;;
let t500 =  insert 13 t400;;

let tmm = merge t50 t500;;
let tr = remove 0 t;;


let t0 = Empty;;
let t1 =  insert 'h' t0;;
let t2 =  insert 'k' t1;;
let t3 =  insert 'z' t2;;
let t4 =  insert 'c' t3;;
let t5 =  insert 'o' t4;;
let t6 =  insert 'w' t5;;
let t7 =  insert 'f' t6;;
let t8 =  insert 'a' t7;;
let t9 =  insert 'p' t8;;
let t10 = insert 'm' t9;;
let t = insert 'e' t10;;

mem 'e' t;;
mem 'x' t;;
mem 'f' t;;
mem 'z' t;;

min_elem t;;
let tm = remove_min_elem t;;

let t10 =  insert 'o' t0;;
let t20 =  insert 'l' t10;;
let t30 =  insert 'i' t20;;
let t40 =  insert 'v' t30;;
let t50 =  insert 'i' t40;;
let t60 =  insert 'e' t50;;
let t70 =  insert 'r' t60;;

let t100 =  insert 'z' t0;;
let t200 =  insert 'y' t100;;
let t300 =  insert 'x' t200;;
let t400 =  insert 'w' t300;;
let t500 =  insert 'v' t400;;

let tmm = merge t70 t500;;
let tr = remove 'o' tmm;;
