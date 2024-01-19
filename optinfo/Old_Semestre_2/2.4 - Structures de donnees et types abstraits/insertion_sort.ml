
(* tri par insertion *)
let rec insert_elem sorted e =
    match sorted with
        | [] -> [e]
        | h::t when h < e -> h::(insert_elem t e)
        | h::t ->  e::h::t;;

let rec insert_sort l =
        match l with
           | [] ->  []
           | e::t ->  insert_elem (insert_sort t) e;;

let insert_sort l =
    let rec aux to_sort sorted =
        match to_sort with
           | [] ->  sorted
           | e::t -> aux t (insert_elem sorted e)
    in aux l [];;


(* tests *)
let test_sorted_list = [1;7;12;27;36;42;54;66;73;88;99];;
let test_list = [1;42;99;66;36;12;7;27;73;36;54;88];;
test_list;;
insert_elem test_sorted_list 5;;
insert_sort test_list;;
insert_sort test_list;;
