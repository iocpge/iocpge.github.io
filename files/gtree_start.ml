(* où l'on aborde les fonctions mutuellement récursives *)
type 'a gtree =
    | Vide
    | Noeud of 'a * 'a gtree list;;

let rec hauteur a = () (* TODO *);;

let rec h a = () (* TODO mutuelle récursive *);;

let rec taille a = () (* TODO *);;

let rec size a = () (* TODO mutuelle récursive *);;

let bfs a = () (* TODO *);;

let rec dfs a = () (* TODO *);;

type 'a btree =
  | BVide
  | BNoeud of 'a * 'a btree * 'a btree;;

let rec convert_to_btree a = () (* TODO *);;


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


