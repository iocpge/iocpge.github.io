(* travail sur les Array -> structure muable *)

let swap t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp;;

let get_min_index t start =
  let index = ref start in
  for i = start to (Array.length t) - 1 do
    if t.(i) < t.(!index) then index := i 
  done;
  !index;;

let select_sort t =
  for i = 0 to (Array.length t) - 1 do
    let min_index = get_min_index t i in swap t i min_index
  done;;

(* TESTS *)
let a = [|3;5;7;1|];;
swap a 0 3;;
a;;
get_min_index [|3;-4;6;0;-43;15;16;1|] 0;;
get_min_index [|3;-4;6;0;-43;15;16;1|] 5;;

let a = [||];;
select_sort a;;
a;;
let a =[|3|];;
select_sort a;;
a;;
let a =[|5;-3|];;
select_sort a;;
a;;
let a = [|3;9;2;4;5;1;7;6;8|];;
select_sort a;;
a;;
