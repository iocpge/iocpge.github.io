let rec rm_first_occ e l =
  match l with
  | [] -> []
  | h::t when h = e -> t
  | h::t -> h :: (rm_first_occ e t);;

let choisir_pivot lst =
      let n = List.length lst in
      if n = 0
      then failwith "Empty list"
      else List.nth lst (Random.int n);; (* List.nth est en  O(n) *)

let rec partitionner l pivot =
    match l with
    | [] -> [],[]
    | h::t when h < pivot -> let (l1,l2) = partitionner t pivot in (h::l1,l2)
    | h::t -> let (l1,l2) = partitionner t pivot in (l1,h::l2);;

let rec trier_rapide l =
    match l with
    | []->[]
    | [_] -> l
    | _::_ ->  let pivot = choisir_pivot l
               in  let (l1,l2) = partitionner (rm_first_occ pivot l) pivot
               in  trier_rapide l1 @ pivot::(trier_rapide l2);;

let t = [3;9;0;0;1;7;4;5;5;2;6];;
partitionner t ;;
trier_rapide t;;
