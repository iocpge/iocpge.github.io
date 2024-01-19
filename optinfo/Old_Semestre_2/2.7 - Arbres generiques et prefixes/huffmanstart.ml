(* arbre binaire avec étiquettes int (occurrences) et feuilles char (symboles) *)
type btree = Leaf of char
           | Node of int * btree * btree;;

let string_to_list s = s |> String.to_seq |> List.of_seq;;

let string_to_char_list s =  List.of_seq  (String.to_seq s);;

let occurences s =
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

let compare (_,n1) (_,n2) = 0 ;;

let rec insert_elem sorted e = [];;

let rec insert_sort l = [];;

let merge a1 a2 = Leaf 'H';;

let huffmann_tree occurences = Leaf 'H';;

let encode_map htree = let map = Hashtbl.create 64 in Hashtbl.add map c "0111"; map;

let h_encode h_map msg =
    let to_encode = string_to_list msg in
    "";;

let h_decode htree msg =
    let to_decode = string_to_char_list msg in
    "";;

let compression_rate text =
    let occ = occurences text in
    let q = insert_sort occ in
    let ht = huffmann_tree q in
    let hmap = encode_map ht in
    let emsg = h_encode hmap text in
    1. -. (float(String.length emsg) /. float(8 * String.length text));;

(* TESTS *)

let cite = "this is an example of a huffman tree";;

let occ = occurences cite;;
let q = insert_sort occ;;
let ht = huffmann_tree q;;
let hmap = encode_map ht;;
let ecite = h_encode hmap cite;;
String.length ecite;;
let dcite = h_decode ht ecite;;

compression_rate cite;;
