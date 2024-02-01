(* tri par insertion --> travail sur les listes et la récursivité *)
let rec insert_elem sorted elem =
    match sorted with
        | [] -> [elem]
        | h::t -> if h >= elem
                  then elem::h::t
                  else h::(insert_elem t elem);;

let test_sorted_list = [1;7;12;27;36;42;54;66;73;88;99];;
insert_elem test_sorted_list 5;;

let rec insert_elem sorted e =
    match sorted with
        | [] -> [e]
        | h::t when h >= e -> e::h::t
        | h::t -> h::(insert_elem t e);;

let test_sorted_list = [1;7;12;27;36;42;54;66;73;88;99];;
insert_elem test_sorted_list 5;;

let rec insert_sort l =
        match l with
           | [] ->  []
           | elem::t ->  insert_elem (insert_sort t) elem;;

let test_list = [1;42;99;27;66;36;12;7;27;73;36;54;88];;
test_list;;
insert_sort test_list;;


let insert_sort l = (* terminal récursif *)
    let rec aux to_sort sorted =
        match to_sort with
           | [] ->  sorted
           | e::t -> aux t (insert_elem sorted e)
    in aux l [];;