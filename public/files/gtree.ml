(* où l'on aborde les fonctions mutuellement récursives *)
type 'a gtree =
    | Vide
    | Noeud of 'a * 'a gtree list;;

let rec hauteur a =
    match a with
    | Vide -> -1
    | Noeud (_, []) -> 0
    | Noeud (_, fils) -> 1 + List.fold_left (fun acc f -> max acc (hauteur f)) 0 fils;;

let rec h a =
        match a with
        | Vide -> -1
        | Noeud (_, []) -> 0
        | Noeud (_, fils) -> 1 + h_fils fils
    and h_fils fils =
        match fils with
        | [] -> 0
        | f::t -> max (h f) (h_fils t);;

let rec taille a =
    match a with
    | Vide -> 0
    | Noeud (_, []) -> 1
    | Noeud (_, fils) -> 1 + List.fold_left (fun acc f -> acc +  (taille f)) 0 fils;;

let rec size a =
        match a with
        | Vide -> 0
        | Noeud (_, []) -> 1
        | Noeud (_, fils) -> 1 + s_fils fils
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
            | Vide -> ()
            | Noeud(e, fils) -> parcours := e :: !parcours;
                               ajouter_fils fils;
   done;
   List.rev !parcours;;

let rec dfs a =
    match a with
    | Vide -> []
    | Noeud(e, fils) -> List.fold_left (fun acc e ->  acc @ dfs e) [e] fils;;

let rec dfs a =
    match a with
    | Vide -> []
    | Noeud(e, fils) -> e :: aux fils
    and aux lst =
        match lst with
        | [] -> []
        | f::t -> dfs f @ aux t;;


type 'a btree =
  | BVide
  | BNoeud of 'a * 'a btree * 'a btree;;

let rec convert_to_btree a =
    match a with
      | Vide -> BVide
      | Noeud (e, []) -> BNoeud (e, BVide, BVide)
      | Noeud (e, f :: t) ->
                  let left = convert_to_btree f
                  and right = convert_forest t in
                  BNoeud (e, left, right)
    and convert_forest lst =
        match lst with
          | [] -> BVide
          | Vide::t ->  convert_forest t
          | Noeud(b, rb) :: t ->  BNoeud (b, convert_forest rb, convert_forest t);;


(* TESTS *)
let gt = Noeud('A', [Noeud('B', [Noeud('C', []); Noeud('D', []); Noeud('E',[])]);
                    Noeud('F', [Noeud('G', []); Noeud('H',[])]);
                    Noeud('I', [Noeud('J', [Noeud('K', []); Noeud('L', []); Noeud('M',[]); Noeud('N',[])])]);
                    Noeud('O', [])]);;

hauteur gt;;
h gt;;
taille gt;;
size gt;;
bfs gt;;
dfs gt;;
convert_to_btree gt;;


