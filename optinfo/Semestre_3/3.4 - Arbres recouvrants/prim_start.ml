type 'a qdata = {value: 'a; priority: int};;
type 'a priority_queue = {mutable first_free: int; heap: 'a qdata array};;

let swap t i j = let tmp = t.(i) in t.(i) <- t.(j); t.(j) <- tmp;;

let rec up heap k = match k with
    | 0 -> ()
    | _ -> let p = (k - 1)/2 in
               if heap.(k).priority < heap.(p).priority then (swap heap k p ; up heap p);;

let rec down heap first_not_used k = match k with
    | n when 2*n + 1 >= first_not_used -> () (* Leave done *)
    | n when 2*n + 1 = (first_not_used - 1) -> if heap.(n).priority > heap.(2*n + 1).priority then swap heap (2*n + 1) n (* Leave done *) (* Leave done *)
    | n -> begin
            let f = if heap.(2*n + 1).priority < heap.(2*n + 2).priority then  2*n +  1 else 2*n + 2 in
            if heap.(n).priority > heap.(f).priority then (swap heap n f; down heap first_not_used f;)
          end;;

let make_priority_queue n (v,p) =
{first_free = 0; heap = Array.init n (fun i -> {value = v; priority=p})};;

let insert pq (v,p) =
  let size = Array.length pq.heap in
  if pq.first_free + 1 > size then failwith "FULL_PRIORITY_QUEUE";
  pq.heap.(pq.first_free) <- {value=v; priority=p};
  up pq.heap pq.first_free;
  pq.first_free <- pq.first_free + 1;;

let get_min pq =
  if pq.first_free = 0 then failwith "EMPTY_PRIORITY_QUEUE";
  let first = pq.heap.(0) in
    pq.first_free <- pq.first_free - 1;
    pq.heap.(0) <- pq.heap.(pq.first_free);
    down pq.heap pq.first_free 0;
    first;;


let prim g start = 0
        (* INITIALISATION *)
     ;;

let gex = [| [(1,1);(2,2);(3,1);(5,5)];
             [(0,1);(2,1)];
             [(0,2);(1,1);(3,2);(4,3)];
             [(0,1); (2,2); (4,2);(5,3);(6,4)];
             [(2,3); (3,2); (6,1)];
             [(0,5); (3,3); (6,3)];
             [(3,4);(4,1);(5,3)] |];;


prim gex 0;;
prim gex 1;;
prim gex 2;;
prim gex 3;;
prim gex 4;;
prim gex 5;;
prim gex 6;;

