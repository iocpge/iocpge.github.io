type ('a,'b) lassoc =  ('a * 'b) list

let students = [("Émilie", 19);("Elouan",20);("Corentin", 18)];;
List.assoc "Corentin" students;;
List.assoc "Zadig" students;;
List.assoc_opt "Zadig" students;;

(*let students = Hashtbl.create 24;;*)
(*Hashtbl.add students "Corentin" 18;;*)
(*Hashtbl.add students "Emilie" 19;;*)
(*Hashtbl.add students "Ouassim" 19;;*)
(*Hashtbl.add students "Elouan" 20;;*)
(*Hashtbl.mem  students "Ouassim";;*)
(*Hashtbl.iter (fun k v -> Printf.printf "%s -> %d ans \n" k v) students;;*)


type label = { key: string; value: int;};;
type dict =   Vide
            | Noeud of label * dict * dict;;

let rec add d k v = Vide;;

let rec mem d k = Vide;;

let rec find d k = failwith "Key error";;

let rec height t= 0;;

let rec prefix t = ();;

let rec infix t = ();;

let rec postfix t = ();;

let avl_balance t = ();;

let rec badd d k v = ();;

let rec min_elem t = ();;  
let rec remove_min_elem t = ();;
let merge ag ad = ();;
let rec remove e t = ();;


(*TESTS *)


