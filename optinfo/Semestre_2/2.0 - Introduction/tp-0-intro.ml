
3 + 3;;   (* est un entier *)
3. +. 4.5;;(* est un flottant *)

4 * 5;;  (* est un entier *)
4. *. 5.;;

let a = 3;;
let b = 4;;
a + b ;;(* est un entier *)

(* affectation et test d'égalité ! *)
a = 5;;   (* est un booléen !! *)
b = a;;  (* est un booléen !! *)
a;;
a = 4;;  (* est un booléen !! *)
let a = 5;;   (* une variable immuable ;-) *)

let recette = 4000;; (* recette est une variable globale *)
let budget = let depenses = 3500 in recette - depenses;;
(* depenses;; *) (* depenses est une variable locale à l'expression precédente *)


(* programmation impérative ref et tableaux *)

(* références *)
let i = ref 0;;
i;; (* référence *)
!i;; (* valeur *)
incr i;;  (* renvoie unit () --> effet *)
i;;
!i;;
i := !i +3;;  (* syntaxe affectation d'une référence *)
!i;;

(* tableau muables *)
let a = Array.make 10 0;;
a;;
a.(3) = 42;;   (* false !!! *)
a;;
a.(3) <- 42;;  (* ! syntaxe de l'affectation d'un élément du tableau *)
a;;

(* chaînes de caractères : immuables  comme en python *)
let s = "Bonjour ";;
s.[3];;
let ch = s ^ " Monsieur !";;   (* concaténation *)
ch;;

(* structure altenative : renvoie un type : else obligatoire *)
if true then 1 else 2;; (* pas de else if *)
if 1 = 2 then "How strange !" else "OK";;
if true then print_int 3;; (* seul cas où else n'est pas obligatoire : renvoyer unit () *)


(* boucle for *)

for i = 0 to Array.length a - 1 do
    a.(i) <- a.(i) + 3; (* unit ! *)
    print_int i;        (* unit ! *)
    print_newline ()   (* unit ! *)
done;;
a;;

(* boucle while *)

let i = ref 0;;
while !i < Array.length a do
    a.(!i) <- a.(!i) * 3; (* unit ! *)
    print_int !i;        (* unit ! *)
    print_newline ();   (* unit ! *)
    incr i              (* unit ! *)
done;;
a;;

(* fonction *)


let perimeter r = 2. *. 3.1415926*. r;;  (* signature : perimeter : float -> float *)
perimeter 1.;;  (* float *)

(* NB la dernière expression calculée est la valeur renvoyée par la fonction. Pas de mot clef return *)

let  perimeter r = let pi = 3.1415926 in 2. *. pi *. r;;  (* pi est une variable locale à la fonction perimeter *)
perimeter 1.;;

let expo a n =
  let r = ref 1 in
  for i = 0 to (n - 1) do
    r := !r * a
  done;
  !r;;
expo 3 4;;

(* Effets : unit () *)
let hello name = print_string ("Hello "^ name ^" !\n");;  (* signature : hello : string -> unit *)
hello "OCaml";;
(* cette fonction en renvoie rien mais à un effet sur la console : elle imprime Hello *)


(* programmation récursive factorielle et pgcd *)
let rec pgcd a b =
    if b =0 (* condition d'arrêt *)
    then a (* un entier *)
    else pgcd b (a mod b);; (* appel récursif *)
pgcd 39 15;;

let rec fact n =
    if n = 0   (* condition d'arrêt *)
    then 1
    else n * fact (n - 1);;    (* appel récursif *)
fact 6;;

(* Curryfication *)
let ajoute a b = a + b;;
ajoute 3 4;; (* c'est un entier *)
ajoute 3;; (* c'est une fonction *)
let ajoute_deux = ajoute 2;; (* ajoute_deux est une fonction curryfiée *)
ajoute_deux 3;;


(* Types algébriques *)
type color = Red | Green | Blue;;  (* type somme *)
type animal = Horse | Goose | Dog | Cat;; (* type somme  *)

let c = Red;; (* c : color = Red *)
let george = Cat;; (* george : animal = Cat *)


(* enregistrement *)
type pion = {c : color; a : animal; n : int};; (* type enregistrement *)

let p1 = {c = Red; a = Goose; n = 3};; 
let p2 = {c = Blue; a = Cat; n = 42};;
p1.c;; (* accès à la couleur d'un pion *)
p2.a;; (* accès à l'animal d'un pion *)

let is_an p =
  match p.a with
  | Horse -> "Cheval"
  | Cat -> "Chat"
  | _ -> "Useless animal !";;

let is_an p =
  match p.a with
  | Horse -> "Cheval"
  | Cat -> "Chat";;

is_an p1;;
is_an p2;;

(* Type option *)
type zipcode = None | Some of int;;
let brest_code = Some 29200;;
let unknown_city = None;;

let extract_dpt zc =
  match zc with
  | None -> 0
  | Some(n)  -> n/1000;;

extract_dpt brest_code;;

(* type inductif *)
let l = [1;2;3];;

let rec sum elements =
  match elements with
  | [] -> 0
  | e::t -> e + (sum t);;

sum l;;


