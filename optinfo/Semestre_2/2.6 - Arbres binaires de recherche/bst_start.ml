type 'a bst = Empty | Node of 'a * 'a bst * 'a bst;;

let rec mem x t = t;;

let rec insert e t = t;;

let rec min_elem t = t;;

let rec remove_min_elem t = t;;

let merge t_inf t_sup = t_sup;;

let rec remove e t = t;;


(* TESTS *)

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
