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

(* en plus c'est récursif terminal, exemple avec factoriel *)
let rec fact n =
    match n with
    | 0 | 1 -> 1
    | n -> n * fact (n - 1);;

let rtfact n =
    let rec aux acc k =
        match k  with
        | 0 | 1 -> acc
        | k -> aux (acc * k) (k-1) in
    aux 1 n;;

let ifact n =
    let acc = ref 1 in
    for k = n downto 2 do
        acc := !acc * k
    done;
    !acc;;


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

(* récursivité terminale *)
fact 7;;
rtfact 7;;
ifact 7;;

(* Liste d'entiers *)

let entiers n =
    let lst = ref [] in
    for i = 1 to n do
        lst := i::!lst
    done;
    !lst;;

let entiers n =
    let rec aux acc k =
        match k  with
        | 0 -> acc
        | _ -> aux (k::acc) (k-1)
    in aux [] n;;

entiers 15;;

(* min et max *)

let lmin l =
    let rec aux vmin lst =
        match lst with
        | [] -> vmin
        | h::t -> aux (min h vmin) t
    in aux max_int l;;

let lmax l =
    let rec aux vmax lst =
        match lst with
        | [] -> vmax
        | h::t -> aux (max h vmax) t
    in aux (-max_int) l;;

let tl = [34;22;-54;99;66;1;0;-1];;
lmin tl;;
lmax tl;;

List.fold_left max (List.hd tl) tl;;
List.fold_left min (List.hd tl) tl;;