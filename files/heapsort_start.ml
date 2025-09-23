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

let heap_make_up t = (* TODO *) ();;


let heap_make_down t =   (* TODO *) ();;
    

let heap_sort t = (* TODO *) ;;



(* TESTS *)
let test = Array.init 10 (fun i -> i) in heap_make_up test; test;;

let test = Array.init 10 (fun i -> i) in heap_make_down test; test;;

let test = Array.init 10 (fun i -> 10 - i) in heap_sort test; test;;

Random.init 42;;
let test = Array.init 1000 (fun _ -> Random.full_int 10000)in heap_sort test; test;;
