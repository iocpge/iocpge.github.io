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

