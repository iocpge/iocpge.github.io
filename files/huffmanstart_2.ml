(* arbre binaire avec étiquettes int (occurrences) et feuilles char (symboles) *)
type btree = Leaf of char
           | Node of int * btree * btree;;

(* pour convertir un string en une char list, plus facile à manipuler récursivement *)
let string_to_char_list s =  List.of_seq  (String.to_seq s);;
(* avec opérateur pipe forward |> *)
let string_to_list s = s |> String.to_seq |> List.of_seq;;

(* Occurrences avec liste d'association *)
let occurrences s =
    let rec count_chars acc s =
        match s with
        | [] -> acc
        | c :: rest ->
            let new_acc =
                match List.assoc_opt (Leaf c) acc with
                | None -> (Leaf c, 1) :: acc
                | Some count -> (Leaf c, count + 1) :: List.remove_assoc (Leaf c) acc
            in
            count_chars new_acc rest
    in
    let char_list = List.of_seq (String.to_seq s) in
  let result = count_chars [] char_list in
  List.rev result;;

(* Exemple d'utilisation *)
let s = "Il vivait sur les bords du Mississippi, Tom Sayer c'est pour nous tous un ami."
let result = occurrences s

(* Occurrences avec table de hachage *)
let occurrences s =
    let dict = Hashtbl.create 64 in (* 64 est un compromis entre 256 et 0 *)
    let n = String.length s in
    for k = 0 to n - 1 do
        let c = s.[k] in
        let v = Hashtbl.find_opt dict c in
        match v with
        | None -> Hashtbl.add dict c 1
        | Some n ->  Hashtbl.replace dict c (n + 1)
    done;
    Hashtbl.fold (fun k v acc -> (Leaf k, v) :: acc) dict [];;

(* Exemple d'utilisation *)
let s = "Il vivait sur les bords du Mississippi, Tom Sayer c'est pour nous tous un ami."
let result = occurrences s

(* Construction de l'arbre d'Huffman à partir de occurrences *)
let compare (_,n1) (_,n2) =  n1 - n2 ;;

let rec insert_elem sorted e = 
  match sorted with
  | [] -> [e]
  | h::t when compare e h < 0 -> e :: sorted
  | h::t -> h:: (insert_elem t e)
;;

let rec insert_sort l = 
   match l with
  | [] -> []
  | h::t -> insert_elem (insert_sort t) h
;;

insert_sort (occurrences s);;


let merge a1 a2 =
     let n1, o1 = a1 in let n2, o2= a2 in 
     (Node(o1+o2, n1, n2), o1+o2)
;;
merge (Leaf 'm', 1) (Leaf 'p', 2);;

let huffmann_tree occurrences = 
    let file = insert_sort occurrences in 
    let rec aux lst =
        match lst with 
          | [] -> failwith "Oups !"
          | [(arbre,_)] -> arbre
          | a1::a2::t -> let fuse = merge a1 a2  
              in aux (insert_elem t fuse)
    in aux file
;;

let s = "mississippi";;
let mtree = huffmann_tree (occurrences s);;

(* Construction du dictionnaire d'encodage pour efficacité du codage *)
let encode_map htree = 
  let map = Hashtbl.create 64 in Hashtbl.add map 'x' "0111"; map;;

let hcode = encode_map mtree;;

(* Fonction d'encodage avec table de hachage *)
let h_encode h_map msg =
    let to_encode = string_to_list msg in "";;

let coded = h_encode hcode s;;

(* Fonction de décodage par lecture de l'arbre d'Huffman *)
let h_decode htree msg =
    let to_decode = string_to_char_list msg in "";;

h_decode mtree coded;;

let compression_rate text =
    let occ = occurrences text in
    let q = insert_sort occ in
    let ht = huffmann_tree q in
    let hmap = encode_map ht in
    let emsg = h_encode hmap text in
    1. -. (float(String.length emsg) /. float(8 * String.length text));;

(* TESTS *)

compression_rate s;;
