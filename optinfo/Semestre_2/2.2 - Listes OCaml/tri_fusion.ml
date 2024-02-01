let rec fusionner l1 l2 =
    match l1, l2 with
    | [], _ -> l2
    | _ , [] -> l1
    | e1 :: t1, e2 :: _  when e1 <= e2 -> e1 :: fusionner t1 l2
    | _ :: _, e2 :: t2 -> e2 :: fusionner l1 t2
    ;;

fusionner [] [];;
fusionner [2] [];;
fusionner [] [3];;
let l1 = [3;5;9;15;17;43];;
let l2 = [2;6;12;24];;
fusionner l1 l2;;

let partager_en_deux l =
    let rec aux lst l1 l2 =
        match lst with
        | [] -> l1, l2 (* condition d'arrêt *)
        | [e] -> e::l1, l2  (* condition d'arrêt *)
        | a :: b :: t -> aux t (a::l1) (b::l2)
    in aux l [] [];;

partager_en_deux [];;
partager_en_deux [3];;
partager_en_deux [3;5];;
let l = [1;3;2;5;4;7;6;9;8];;
partager_en_deux l;;
let l = [1;3;2;5;4;7;6;9;8;42];;
partager_en_deux l;;


let rec trier_fusion l =
    match l with
    | [] | [_]-> l
    | _ -> let l1, l2 = partager_en_deux l in fusionner (trier_fusion l1) (trier_fusion l2);;

trier_fusion [];;
trier_fusion [3];;
trier_fusion [42; -4];;
let l = [1;3;2;5;4;7;6;9;8;-42];;
trier_fusion  l;;