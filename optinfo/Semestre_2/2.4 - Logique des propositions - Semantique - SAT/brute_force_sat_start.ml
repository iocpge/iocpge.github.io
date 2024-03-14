type formule =
  | T (* true *)
  | F (* false *)
  | Var of int (* variable *)
  | Not of formule (* negation *)
  | And of formule * formule (* conjonction *)
  | Or of formule * formule  (* disjonction *)
  | Imp of formule * formule;;

let rec max_var f k = (* k is current index *)
    match f with
    | T | F -> k
    | Var i -> max i k
    | Not fa -> max_var fa k
    | And (fa,fb) | Or  (fa,fb) | Imp (fa,fb) -> max_var fb (max_var fa k);;

(* Renvoiyer le nombre de variables d'une formule logique *)
let nb_var f = ();; (* TODO *)

(* UNE VALUATION EST UN NOMBRE DONT CHAQUE BIT REPRÉSENTE UNE VARIABLE *)
(* bit à 0 --> faux *)
(* bit à 1 --> vrai *)
(* EXEMPLE : 001 -> VAR 0 VRAIE, VAR 1 FAUSSE, VAR 2 FAUSSE *)
let get_var_k_from_v v k = ();; (* TODO *)


(* ÉVALUER UNE FORMULE LOGIQUE D'APRÈS UNE VALUATION (UN NOMBRE) *)
let rec evaluation v f = ();; (* TODO *)

(* UNE FORMULE EST-ELLE SATISFAISABLE ? *)
(* EXISTE-T-IL UNE VALUATION POUR LAQUELLE ELLE EST VRAIE ? *)
(* LES ESSAYER TOUTES ET CONCLURE *)
let brute_force_satisfiability f =
  let n = nb_var f in
  (* n est le nombre de variables propositionnelles de type int de 0 à n-1 *)
  let v_limit = 1 lsl n in
  (* v_limit = 2^n est la plus petite valuation impossible *)
  ();; (* TODO : TESTER TOUTES LES VALUATIONS POSSIBLES *)


(* TESTS *)
