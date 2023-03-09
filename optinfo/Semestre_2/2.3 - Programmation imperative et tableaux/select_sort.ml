let get_min_index t start =
  let index = ref start in
  for i = start to (Array.length t) - 1 do
    if t.(i) < t.(!index) then index := i 
  done;
  !index;;

let swap t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp;;

let select_sort t =
  for i = 0 to (Array.length t) - 1 do
    let min_index = get_min_index t i in swap t i min_index
  done;;

(* main program *)

let a = [|3;9;2;4;5;1;7;6;8|];;
select_sort a;;
a;;
