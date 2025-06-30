(* TAD et structure de données *)
(* Dictionnaire *)

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

type label = { key: string; value: int;};;   (* type enregistrement / record *)

let l1 = {key = "Corentin"; value = 176};;
l1.key;;
l1.value;;

type dict =   Vide
            | Noeud of label * dict * dict;;

let rec add d k v =
    match d with
    | Vide -> Noeud({key = k; value=v}, Vide, Vide)
    | Noeud(l,_,_) when l.key = k -> failwith "Key already recorded"
    | Noeud(l,g,d) when k < l.key -> Noeud(l,add g k v,d)
    | Noeud(l,g,d) -> Noeud(l,g,add d k v);;

let rec mem d k =
    match d with
    | Vide -> false
    | Noeud(l,_,_) when l.key = k -> true
    | Noeud(l,g,_) when k < l.key -> mem g k
    | Noeud(_,_,d) -> mem d k;;

let rec find d k =
    match d with
    | Vide -> failwith "Key error"
    | Noeud(l,_,_) when l.key = k -> l.value
    | Noeud(l,g,_) when k < l.key -> find g k
    | Noeud(_,_,d) -> find d k;;

let rec height t=
    match t with
        | Vide -> -1
        | Noeud(_,g,d) -> 1 + max (height g)  (height d);;

let rec prefix t =
    match t with
    | Vide -> []
    | Noeud(l,g,d) -> l.key :: ( prefix g @ prefix d);;

let rec postfix t =
    match t with
    | Vide -> []
    | Noeud(l,g,d) -> prefix g @ prefix d @ [l.key];;

let rec infix t =
    match t with
    | Vide -> []
    | Noeud(l,g,d) -> infix g @ [l.key] @ infix d;;

let avl_balance t =
   match t with 
   | Vide -> Vide
   | Noeud(x,g,d) -> let (hg, hd) = (height g, height d) in
               if hg > hd + 1 then
               (* begin (* rotation à droite *) *)
                    match g with
                    | Noeud(y, a1, a2) when height a1 >= height a2 ->  Noeud(y, a1, Noeud(x,a2,d))
                    | Noeud(y, a1, Noeud(z, a4, a5)) ->  Noeud(z, Noeud(y, a1, a4), Noeud(x,a5,d))
                    | _ -> failwith "Unknown case"
               (* end *)
               else if hd > hg + 1 then
                begin (* rotation à gauche *)
                   match d with
                    | Noeud(y, a1, a2) when height a2 >= height a1 ->  Noeud(y, Noeud(x,g,a1), a2)
                    | Noeud(y, Noeud(z, a4, a5), a2) -> Noeud(z, Noeud(x, g, a4), Noeud(y,a5,a2))
                    | _ -> failwith "Unknown case"
                end
               else t;;

let rec badd d k v =
    match d with
    | Vide -> Noeud({key = k; value=v}, Vide, Vide)
    | Noeud(l,_,_) when l.key = k -> failwith "Key already recorded"
    | Noeud(l,g,d) when k < l.key -> avl_balance (Noeud(l,badd g k v,d))
    | Noeud(l,g,d) -> avl_balance (Noeud(l,g,badd d k v));;

let rec min_elem t =
  match t with
  | Vide -> failwith "No min"
  | Noeud(e, Vide, _) -> e
  | Noeud(_,g,_) -> min_elem g;;
  
let rec remove_min_elem t =
  match t with
  | Vide -> failwith "No min"
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
  | Vide -> failwith "Nothing to remove !"
  | Noeud(x,g,d) when x.key = e -> avl_balance(merge g d)
  | Noeud(x,g,d) when e < x.key -> avl_balance (Noeud(x, remove e g, d))
  | Noeud(x,g,d) -> avl_balance (Noeud(x,g,remove e d));;
  ;;

(*TESTS *)

let d = Vide;;
let d = add d "Emilie" 165;;
let d = add d "Elouan" 175;;
let d = add d "Sasha" 170;;
let d = add d "Corentin" 175;;
let d = add d "Ouassim" 170;;
let d = add d "Jacques" 175;;
let d = add d "Alex" 178;;
let d = add d "Pablo" 180;;
let d = add d "Aurélien" 167;;
let d = add d "Camille" 170;;
let d = add d "Flavie" 165;;
let d = add d "Lucille" 170;;
let d = add d "Ruben" 169;;
let d = add d "Gwénolé" 168;;
let d = add d "Gaël" 167;;
let d = add d "Hugo" 167;;

find d "Emilie";;
find d "Hugo";;
let d = add d "Olivier" 169;;

prefix d;;
infix d;;

height d;;
let d = avl_balance d;;
height d;;

let d = Vide;;
let d = badd d "Emilie" 178;;
let d = badd d "Alice" 167;;
let d = badd d "Alex" 167;;
let d = badd d "Pablo" 170;;
let d = badd d "Aude" 175;;
let d = badd d "Aurelien" 165;;
let d = badd d "Audrey" 175;;

prefix d;;
infix d;;
postfix d;;
height d;;
d;;

remove "Emilie" d;;
remove "Alex" d;;
remove "Aude" d;;



