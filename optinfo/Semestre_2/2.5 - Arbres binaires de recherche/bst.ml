type 'a abr = Vide | Noeud of 'a * 'a abr * 'a abr;;

let rec mem x t =
  match t with
  | Vide -> false
  | Noeud(e,g,_) when x = e -> true
  | Noeud(e,g,_) when x < e -> mem x g
  | Noeud(e,_,d)  -> mem x d;;

let rec insert e t =
  match t with
  | Vide -> Noeud(e, Vide, Vide)
  | Noeud(x,g,d) when e <= x -> Noeud(x, insert e g, d)
  | Noeud(x,g,d) -> Noeud(x, g, insert e d);;

let rec min_elem t =
  match t with
  | Vide -> failwith "Pas de minimum pour Vide !"
  | Noeud(e, Vide, _) -> e
  | Noeud(_,g,_) -> min_elem g;;

let rec min_elem_o t =
  match t with
  | Vide -> None
  | Noeud(e, Vide, _) -> Some e
  | Noeud(_,g,_) -> min_elem_o g;;

let rec remove_min_elem t =
  match t with
  | Vide -> failwith "Pas de minimum pour Vide !"
  | Noeud(_,Vide, d) -> d
  | Noeud(e,g,d) -> Noeud(e, remove_min_elem g, d);;

let merge ag ad =
  match ag, ad with
  | Vide, _  -> ad
  | _ , Vide -> ag
  | Noeud(_,_,_), Noeud(_,_,_) -> let m = min_elem ad in
                                  Noeud(m, ag, remove_min_elem ad);;

let rec remove e t =
  match t with
  | Vide -> failwith "Rien à enlever de Vide !"
  | Noeud(x,g,d) when x = e -> merge g d
  | Noeud(x,g,d) when e < x -> Noeud(x, remove e g, d)
  | Noeud(x,g,d) -> Noeud(x,g,remove e d);;
  ;;


(* TESTS *)
let a = Noeud(5,
             Noeud(3,
                  Noeud(1, Vide, Vide),
                  Noeud(4, Vide, Vide)),
             Noeud(8,
                  Noeud(6,Vide, Vide),
                  Noeud(9,Vide, Vide))
          );;

mem 6 a;;
insert 10 a;;
insert 7 a;;
min_elem Vide;;

try min_elem Vide with
| Failure "Pas de minimum pour Vide arbre !" ->  3
| _ -> 0;;

min_elem a;;


let t0 = Vide;;
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


let t0 = Vide;;
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
