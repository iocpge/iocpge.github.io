let swap t i j = let tmp = t.(i) in t.(i) <- t.(j); t.(j) <- tmp;;

let rec up heap k =
  match k with
    | 0 -> ()
    | _ -> let f = (k - 1)/2 in
           if heap.(k) > heap.(f) then (swap heap k f ; up heap f);;

let rec down heap first_not_used k =
  match k with
    | n when 2*n + 1 >= first_not_used -> () (* Out of bounds, it is done *)
    | n when 2*n + 1 = (first_not_used - 1) -> if heap.(n) < heap.(2*n + 1) then swap heap (2*n + 1) n (* just one last child *)
    | _ -> begin (* two children ! *)
            let c = if heap.(2*k + 1) > heap.(2*k + 2) then  2*k +  1 else 2*k + 2 in
            if heap.(k) < heap.(c) then (swap heap k c; down heap first_not_used c;)
           end;;


(* TESTS *)
let heap_test = Array.init 10 (fun i -> 10 - i);;
swap heap_test 3 7;;
heap_test;;
up heap_test 7;;
heap_test;;

let heap_test = Array.init 10 (fun i -> 10 - i);;
swap heap_test 3 7;;
down heap_test 10 3;;
heap_test;;
swap heap_test 0 9;;
heap_test;;
down heap_test 10 0;;
heap_test;;


(*
let test = Array.init 10 (fun i -> 10 - i);;
heap_sort test;;
test;;

Random.init 42;;
let test = Array.init 1000 (fun _ -> Random.full_int 10000);;
heap_sort test;;
test;;

let stable = [|12;21;20;20;11;8;7|];;
heap_sort stable;;
stable;;*)
