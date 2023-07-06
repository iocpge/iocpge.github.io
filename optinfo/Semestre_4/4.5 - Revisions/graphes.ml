(*On souhaite représenter un graphe orienté en machine.*)
(*Pour chaque structure de données ci-dessous représentant un graphe, programmer :*)
(*- mem_arete : qui teste si une arrête est présente dans le graphe*)
(*- add_arete qui ajoute une arête dans le graphe*)
(*- remove_arete qui retire une arête du graphe*)
(*- iter_voisins qui permet d'appliquer une fonction à tous les voisins d'un sommet s du graphe*)
(*- iter_sommets qui permet d'appliquer une fonction à tous les sommets du graphe*)
(*- iter_aretes qui permet d'appliquer une fonction à toutes les arêtes du graphe*)
(* POUR CHAQUE FONCTION ON PRECISERA LA COMPLEXTIE TEMPORELLE. *)
(* ON COMPARERA LES COMPLEXITE TEMPORELLE DANS LES TROIS STRUCTURES. *)
(* ON S'AUTORISE À UTILISER TOUTES LES FONCTIONS DES MODULES ARRAY, LIST et HASHTBL *)


type sommet = int


(*Matrices d'adjacence*)
type adjmat = bool array array

let create n = Array.make_matrix n n false;;
let mem_arete (g : adjmat) (a : sommet) (b : sommet) : bool = false;;
let add_arete (g : adjmat) (a : sommet) (b : sommet) : unit = ();;
let remove_arete (g : adjmat) (a : sommet) (b : sommet) : unit = ();;
let iter_voisins (f : sommet -> unit) (g : adjmat) (s : sommet) : unit = ();;
let iter_sommets (f : sommet -> unit) (g : adjmat) : unit = ();;
let iter_aretes (f : sommet -> sommet -> unit) (g : adjmat) : unit = ();;

(*Listes d'adjacence*)
type adjlst = bool list array

let create n = Array.make n [];;
let mem_arete (g : adjlst) (a : sommet) (b : sommet) : bool = false;;
let add_arete (g : adjlst) (a : sommet) (b : sommet) : unit = ();;
let remove_arete (g : adjlst) (a : sommet) (b : sommet) : unit = ();;
let iter_voisins (f : sommet -> unit) (g : adjlst) (s : sommet) : unit = ();;
let iter_sommets (f : sommet -> unit) (g : adjlst) : unit = ();;
let iter_aretes (f : sommet -> sommet -> unit) (g : adjlst) : unit = ();;

(*Dictionnaires d'adjacence*)
type adjdict = (int, (int, int) Hashtbl.t) Hashtbl.t;;

let create n = Hashtbl.create n;;
let mem_arete (g : adjdict) (a : sommet) (b : sommet) : bool = false;;
let add_arete (g : adjdict) (a : sommet) (b : sommet) : unit = ();;
let remove_arete (g : adjdict) (a : sommet) (b : sommet) : unit = ();;
let iter_voisins (f : sommet -> unit) (g : adjdict) (s : sommet) : unit = ();;
let iter_sommets (f : sommet -> unit) (g : adjdict) : unit = ();;
let iter_aretes (f : sommet -> sommet -> unit) (g : adjdict) : unit = ();;


(*Exemples d'utilisation de HashTbl*)
let g  = Hashtbl.create 64;;
Hashtbl.add g 0 (let edges = Hashtbl.create 64 in Hashtbl.add edges 1 0; edges);;
Hashtbl.find (Hashtbl.find g 0) 1;;
Hashtbl.mem (Hashtbl.find g 0) 1;;
Hashtbl.replace (Hashtbl.find g 0) 1 42;;
Hashtbl.find (Hashtbl.find g 0) 1;;
Hashtbl.add (Hashtbl.find g 0) 2 66;;
Hashtbl.find (Hashtbl.find g 0) 2;;




