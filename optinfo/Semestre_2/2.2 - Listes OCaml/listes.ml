
let rec length l =
  match l with
  | [] -> 0
  | _::t -> 1 + length t;;

let rec mem x l =
  match l with
  | [] -> false
  | h::t when h = x -> true
  | _::t -> mem x t;;

let rec rm e l =
  match l with
  | [] -> []
  | h::t when h = e -> rm e t
  | h::t -> h :: (rm e t);;

let rec at k l =
  match l with
  | [] -> failwith "List too short !"
  | h::t when k = 0 -> h
  | _::t -> at (k - 1) t;;

let rec option_at k l =
  match l with
  | [] -> None
  | h::t when k = 0 -> Some h
  | _::t -> option_at (k - 1) t;;

(* Introduction du concept de mapping *)
let rec l_square l =
  match l with
  | [] -> []
  | h::t -> h*h :: l_square t;; 

let rec l_slength l =
  match l with
  | [] -> []
  | h::t -> String.length h :: l_slength t;;

(* [ f a; f b; f c; ... ; f z ] *)  
let rec map f l =
  match l with
  | [] -> []
  | h::t -> f h :: map f t;;

(* Introduction de l'itération *)
let rec print_list l =
  match l with
  | [] -> Printf.printf "\n"
  | h::t -> Printf.printf "%d " h; print_list t;;

(* f a; f b; f c; .... ; f z *)
let rec iter f l =
  match l with
  | [] -> ()
  | h::t -> f h; iter f t;; 


(* Introduction du folding *)

let rec l_sum l =
  match l with
  | [] -> 0
  | h::t -> h + l_sum t;;

let rec l_square_sum l =
  match l with
  | [] -> 0
  | h::t -> h*h + l_square_sum t;;

let rec l_sconcat sl =
  match sl with
  | [] -> ""
  | h::t -> h ^ l_sconcat t;;

let rec fold_left f acc l =
  match l with
  | [] -> acc
  | h::t -> fold_left f (f acc h) t;;

(* tests *)
let l = [9;3;1;7;3;5;3;1;9];;
let n = length l;;
mem 0 l;;
mem 3 l;;
rm 0 l;;
rm 3 l;;
at 3 l;;
at 15 l;;
option_at 15 l;;
option_at 3 l;;

(* mapping *)
l_square l;;
let sl = ["Hello"; "Goodbye"; "Beatles"];;
l_slength sl;;

map String.length sl;;

(* iter *)
print_list l;;
iter print_int l;;
iter (fun e -> Printf.printf "%d " e) l;;
iter print_string sl;;
iter (fun s -> Printf.printf "%s " s) sl;;

(* folding *)
l_sum l;;
l_square_sum l;;
l_sconcat sl;;
fold_left (+) 0 l;;
fold_left (fun acc e -> acc + e*e) 0 l;;
fold_left (fun acc e -> acc ^ e) "" sl;;
