
(* échanger les éléments d'indice i et j dans t *)
let swap t i j = ();; (* TODO *)

(* faire monter l'élément d'indice k dans le tas min *)
let rec up heap k = ();; (* TODO *)

(* faire descendre l'élément d'indice k dans le tas min *)
let rec down heap first_not_used k = ();; (* TODO *)

(* créer un tas min à partir d'un tableau en faisant monter les éléments *)
let heapify_up t = ();; (* TODO *)

(* créer un tas min à partir d'un tableau en faisant descendre les éléments *)
let heapify_down t = ();; (* TODO *)

(* trier par tas min dans l'ordre décroissant *)
let heap_sort t = ();; (* TODO *)


(* tests *)
let heap_test = Array.init 10 (fun i -> 10 - i);;
swap heap_test 3 7;;
heap_test;;
up heap_test 7;;

swap heap_test 3 7;;
heap_test;;
down heap_test 10 3;;
heap_test;;
swap heap_test 0 9;;
heap_test;;
down heap_test 10 0;;
heap_test;;

let test = Array.init 10 (fun i -> 10 - i);;
heapify_up test;;
test;;

let test = Array.init 10 (fun i -> 10 - i);;
heapify_down test;;
test;;

let test = Array.init 10 (fun _ -> Random.full_int 20);;
heap_sort test;;
test;;


Random.init 42;;
let test = Array.init 1000 (fun _ -> Random.full_int 10000);;
heap_sort test;;
test;;

let stable = [|12;20;20;21;11;8;7|];;
heap_sort stable;;
stable;;

