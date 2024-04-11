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

let avl_balance t =
   match t with
   | Vide -> Vide
   | Noeud(x,g,d) -> let (hg, hd) = (height g, height d) in
               if hg > hd + 1 then
               begin (* rotation à droite *)
                    match g with
                    | Noeud(y, a1, a2) when height a1 >= height a2 ->  Noeud(y, a1, Noeud(x,a2,d))
                    | Noeud(y, a1, Noeud(z, a4, a5)) ->  Noeud(z, Noeud(y, a1, a4), Noeud(x,a5,d))
                    | _ -> failwith "Unknown case"
               end
               else if hd > hg + 1 then
                begin (* rotation à gauche *)
                   match d with
                    | Noeud(y, a1, a2) when height a2 >= height a1 ->  Noeud(y, Noeud(x,g,a1), a2)
                    | Noeud(y, Noeud(z, a4, a5), a2) -> Noeud(z, Noeud(x, g, a4), Noeud(y,a5,a2))
                    | _ -> failwith "Unknown case"
                end
               else t;;

let rec badd d k v = ();;

let rec min_elem t = ();;  
let rec remove_min_elem t = ();;
let merge ag ad = ();;
let rec remove e t = ();;


(*TESTS *)


