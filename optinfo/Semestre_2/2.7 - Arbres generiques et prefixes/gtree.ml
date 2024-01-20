(* où l'on aborde les fonctions mutuellement récursives *)

type 'a gtree =
    | Empty
    | Node of 'a * 'a gtree list;;

let rec hauteur a =
    match a with
    | Empty -> -1
    | Node (_, []) -> 0
    | Node (_, fils) -> 1 + List.fold_left (fun acc f -> max acc (hauteur f)) 0 fils;;

let rec h a =
        match a with
        | Empty -> -1
        | Node (_, []) -> 0
        | Node (_, fils) -> 1 + h_fils fils
    and h_fils fils =
        match fils with
        | [] -> 0
        | f::t -> max (h f) (h_fils t);;

let rec taille a =
    match a with
    | Empty -> 0
    | Node (_, []) -> 1
    | Node (_, fils) -> 1 + List.fold_left (fun acc f -> acc +  (taille f)) 0 fils;;

let rec size a =
        match a with
        | Empty -> 0
        | Node (_, []) -> 1
        | Node (_, fils) -> 1 + s_fils fils
    and s_fils fils =
        match fils with
        | [] -> 0
        | f::q ->  size f  +  s_fils q;;

let bfs a =
   let file = Queue.create () and parcours = ref [] in
   let rec ajouter_fils fl =
          match fl with
          | [] -> ()
          | h::t -> Queue.add h file; ajouter_fils t in
   Queue.add a file;
   while Queue.length file > 0 do
        let tt = Queue.take file in
        match tt with
            | Empty -> ()
            | Node(e, fils) -> parcours := e :: !parcours;
                               ajouter_fils fils;
   done;
   List.rev !parcours;;

let rec dfs a =
    match a with
    | Empty -> []
    | Node(e, fils) -> List.fold_left (fun acc e ->  acc @ dfs e) [e] fils;;

let rec dfs a =
    match a with
    | Empty -> []
    | Node(e, fils) -> aux [e] fils
    and aux acc lst =
        match lst with
        | [] -> acc
        | f::t -> aux (acc @ dfs f) t;;

type 'a btree =
  | BEmpty
  | BNode of 'a * 'a btree * 'a btree;;

let rec convert_to_btree a =
    match a with
      | Empty -> BEmpty
      | Node (e, []) -> BNode (e, BEmpty, BEmpty)
      | Node (e, f :: t) ->
                  let left = convert_to_btree f
                  and right = convert_forest t in
                  BNode (e, left, right)
    and convert_forest lst =
        match lst with
          | [] -> BEmpty
          | Empty::t ->  convert_forest t
          | Node(b, rb) :: t ->  BNode (b, convert_forest rb, convert_forest t);;


(* TESTS *)
let gt = Node('A', [Node('B', [Node('C', []); Node('D', []); Node('E',[])]);
                    Node('F', [Node('G', []); Node('H',[])]);
                    Node('I', [Node('J', [Node('K', []); Node('L', []); Node('M',[]); Node('N',[])])]);
                    Node('O', [])]);;

hauteur gt;;
h gt;;
taille gt;;
size gt;;
bfs gt;;
dfs gt;;
convert_to_btree gt;;


