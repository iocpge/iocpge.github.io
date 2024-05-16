(* arbre binaire avec étiquettes int (occurrences) et feuilles char (symboles) *)
type btree = Leaf of char
           | Node of int * btree * btree;;

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

let compare (_,n1) (_,n2) = n1 - n2 ;;

let rec insert_elem sorted e =
    match sorted with
        | [] -> [e]
        | h::t when compare h e <= 0 -> h::(insert_elem t e)
        | h::t ->  e::h::t;;

let rec insert_sort l =
        match l with
           | [] ->  []
           | e::t ->  insert_elem (insert_sort t) e;;

let merge a1 a2 = let (n1, o1) = a1  and (n2, o2) = a2 in
                  (Node((o1 + o2), n1, n2), o1 + o2);;

let huffmann_tree occurences =
     let rec build_tree q =
        match q with
            | [] -> failwith "Can not build a tree from nothing..."
            | [(t,_)] -> t (* the final tree ! *)
            | n1::n2::t ->  let m = merge n1 n2 in build_tree (insert_elem t m) in
     build_tree occurences;;

let string_to_char_list s =  List.of_seq  (String.to_seq s);;

string_to_char_list "Olivier";;

(*let encode_map htree =*)
(*    let map = Hashtbl.create 64 in*)
(*    let rec down acc ht =*)
(*        match ht with*)
(*        | Leaf c -> Hashtbl.add map c (String.of_seq (List.to_seq (List.rev acc)))*)
(*        | Node(_, t1, t2) -> down ('0'::acc) t1; down ('1'::acc) t2 in*)
(*    down [] htree;*)
(*    map;;*)


let encode_map htree =
    let map = Hashtbl.create 64 in
    let rec down acc ht =
        match ht with
        | Leaf c -> Hashtbl.add map c acc
        | Node(_, t1, t2) -> down (acc^"0") t1; down (acc^"1") t2 in
    down "" htree;
    map;;

(*let h_encode h_map msg =*)
(*    let to_encode = string_to_char_list msg in*)
(*    let rec aux bits to_e =*)
(*        match to_e with*)
(*        | [] -> bits*)
(*        | c::t -> aux (bits ^ (Hashtbl.find h_map c)) t in*)
(*    aux "" to_encode;;*)

let h_encode h_map msg =
    let to_encode = string_to_char_list msg in
    let rec aux to_e =
        match to_e with
        | [] -> ""
        | c::t -> (Hashtbl.find h_map c) ^ (aux  t) in
    aux to_encode;;


(*let h_decode htree msg =*)
(*    let to_decode = string_to_char_list msg in*)
(*    let rec down acc ht m =*)
(*        match (ht, m) with*)
(*        | (Leaf c, []) -> acc ^ String.make 1 c (* msg done *)*)
(*        | (Leaf c, r) -> down (acc ^ String.make 1 c) htree r (* restart at root *)*)
(*        | (Node(_, t1, _), b::q) when b = '0' -> down acc t1 q*)
(*        | (Node(_, _, t2), b::q) when b = '1' -> down acc t2 q*)
(*        | _ -> failwith "Decoding error !"  in*)
(*    down "" htree to_decode;;*)

let h_decode htree msg =
    let to_decode = string_to_char_list msg in
    let rec down ht m =
        match (ht, m) with
        | (Leaf c, []) -> String.make 1 c (* msg done *)
        | (Leaf c, r) ->  String.make 1 c ^ (down htree r) (* restart at root *)
        | (Node(_, t1, _), b::q) when b = '0' -> down t1 q
        | (Node(_, _, t2), b::q) when b = '1' -> down t2 q
        | _ -> failwith "Decoding error !"  in
    down htree to_decode;;

let compression_rate text =
    let occ = occurences text in
(*    let q = List.sort occ_compare occ in*)
    let q = insert_sort occ in
    let ht = huffmann_tree q in
    let hmap = encode_map ht in
    let emsg = h_encode hmap text in
    let dmsg = h_decode ht emsg in
    1. -. (float(String.length emsg) /. float(8 * String.length text));;

(* TESTS *)


let cite = "Mississippi";;
String.length cite;;
let occ = occurences cite;;
let q = insert_sort occ;;
let ht = huffmann_tree q;;
let hmap = encode_map ht;;
let ecite = h_encode hmap cite;;
String.length ecite;;
let dcite = h_decode ht ecite;;
compression_rate cite;;


let cite = "abracadabra";;
String.length cite;;
let occ = occurences cite;;
let q = insert_sort occ;;
let ht = huffmann_tree q;;
let hmap = encode_map ht;;
let ecite = h_encode hmap cite;;
String.length ecite;;
let dcite = h_decode ht ecite;;
compression_rate cite;;


let frost = "The Road Not Taken

Two roads diverged in a yellow wood,
And sorry I could not travel both
And be one traveler, long I stood
And looked down one as far as I could
To where it bent in the undergrowth;

Then took the other, as just as fair,
And having perhaps the better claim,
Because it was grassy and wanted wear;
Though as for that the passing there
Had worn them really about the same,

And both that morning equally lay
In leaves no step had trodden black.
Oh, I kept the first for another day!
Yet knowing how way leads on to way,
I doubted if I should ever come back.

I shall be telling this with a sigh
Somewhere ages and ages hence:
Two roads diverged in a wood, and I—
I took the one less traveled by,
And that has made all the difference.";;

compression_rate frost;;
