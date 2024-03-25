type 'a htree =
  | Leaf of 'a * int
  | Node of 'a * int * 'a htree * 'a htree

type 'a qdata = {value: 'a; priority: int};;
type 'a priority_queue = {mutable first_free: int; heap: 'a qdata array};;

let swap t i j = let tmp = t.(i) in t.(i) <- t.(j); t.(j) <- tmp;;

let heap_test = Array.init 10 (fun i -> i);;

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

let make_priority_queue n (v,p) = {first_free = 0; heap = Array.init n (fun _ -> {value = v; priority=p})};;

let qsize pq = pq.first_free;;

let is_empty pq = pq.first_free = 0;;

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

let pq = make_priority_queue 10 (-1, max_int);;
Random.init 42;;
for k=0 to 9 do
        let v = Random.full_int 100 and p = Random.full_int 100 in
        insert pq (v,p);
(*        Printf.printf "(value=%i,priority=%i)\n" v p;*)
    done;;
pq;;
for k = 1 to 11 do let m = get_min pq in Printf.printf "min --> (%i, %i)\n" m.value m.priority  done;;
pq;;


let occurences s =
    let dict = Hashtbl.create 64 in (* 64 est un compromis entre 256 et 0 *)
    let n = String.length s in
    for k = 0 to n - 1 do
        let c = String.make 1 s.[k] in
        let v = Hashtbl.find_opt dict c in
        match v with
        | None -> Hashtbl.add dict c 1
        | Some n ->  Hashtbl.replace dict c (n + 1)
    done;
    Hashtbl.fold (fun k v acc -> (Leaf (k, v)) :: acc) dict [];;

let mot = "ressasser";;
occurences mot;;

let set_pq word =
    let n = String.length word in
    let pq = make_priority_queue n ((Leaf("_",0)), max_int) in
    let rec set_pq lst =
        match lst with
        | [] -> ()
        | Leaf(s,p) :: t -> insert pq (Leaf(s,p),p); set_pq t
        | _ -> failwith "Should be leaves" in
    set_pq (occurences word);
    pq;;

let pp = set_pq mot;;

let merge n1 n2 =
    match n1, n2 with
    | Leaf(s1, p1), Leaf(s2, p2) ->
         let g,d = if p1 <= p2 then Leaf(s1, p1), Leaf(s2, p2) else Leaf(s2, p2), Leaf(s1, p1) in
         Node(s1^s2, p1+p2, g, d)
    | Leaf(s1, p1), Node(s2, p2, g2, d2) -> 
         let g,d = if p1 <= p2 then Leaf(s1, p1), Node(s2, p2, g2, d2) else Node(s2, p2, g2, d2), Leaf(s1, p1) in
         Node(s1^s2, p1+p2, g, d)
    | Node(s1, p1, g1, d1), Leaf(s2, p2) -> 
         let g,d = if p1 <= p2 then Node(s1, p1, g1, d1), Leaf(s2, p2) else  Leaf(s2, p2), Node(s1, p1, g1, d1) in
         Node(s1^s2, p1+p2, g, d)
    | Node(s1, p1, g1, d1), Node(s2, p2, g2, d2) -> 
         let g,d = if p1 <= p2 then Node(s1, p1, g1, d1), Node(s2, p2, g2, d2) else  Node(s2, p2, g2, d2), Node(s1, p1, g1, d1) in
         Node(s1^s2, p1+p2, g, d);;

let huffman_tree word =
    let pq = set_pq word in
    while (qsize pq) > 1 do
        let n1 = get_min pq in
        let n2 = get_min pq in
         let m = merge n1.value n2.value in
         match m with 
            | Leaf(_,_) -> failwith "Impossible " 
            | Node(s,p,_,_) -> print_string s; print_newline (); insert pq (m,p)
    done;
    let t = get_min pq in t.value;;

let mytree = huffman_tree mot;;

let letter_to_code letter ht =
    let rec down w tree =
        match tree with
        | Leaf(_,_)  -> w
        | Node(s,_,g,d) ->
                match g,d with
                | Leaf(sg,_), _ when String.contains sg letter  ->  down (w ^ "0") g
                | _, Leaf(sd, _) when String.contains sd letter  -> down (w ^ "1") d
                | Node(sg,_,_,_), _ when String.contains sg letter  -> down (w ^ "0") g
                | _, Node(sd,_,_,_) when String.contains sd letter  -> down (w ^ "1") d
                | _, _ -> failwith "Unknown situation..."  in
    down "" ht;;


let encode mot ht =
     let w = ref "" in
     for i = 0 to String.length mot - 1 do
        print_char mot.[i]; print_newline ();
        w := !w ^ (letter_to_code mot.[i] ht)
     done;
     !w;;

let mot = "mississipi";;
let mytree = huffman_tree mot;;
encode "mpsi" mytree;;


