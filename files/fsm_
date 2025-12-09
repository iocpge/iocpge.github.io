type fsm = { states : int list;
             alphabet : char list;
             initial : int;
             trans_f : int -> char -> int option;
             accepting : int list};;

let up_to a word = ();; (* TODO *)

let match_word a word =  ();; (* TODO *)

let is_complete a = ();;

let complete a =  ();;

let complement a = ();;

let succ a q = ();;

let fsm_to_graph a = ();; 

let accessible_states a = ();;
  
let switch_direction g = ();;
  
let coaccessible_states a = ();;
  
let dfs g v0 = ();;
  
let is_finite_language a = ();;
  
(* TEST *)

let sigma  = ['a'; 'b'; 'c'];;
let states = [0; 1; 2];;

let delta prev letter =
    match (prev, letter) with
        | (0,'a') -> Some 1
        | (0,'c') -> Some 1
        | (0,'b') -> Some 2
        | (2,'b') -> Some 2
        | (2,'c') -> Some 1
        | _ -> None;;

let final_states = [1];;

let automata = {states = states;
                alphabet = sigma;
                initial = 0;
                trans_f = delta;
                accepting = final_states};;

automata.trans_f 2 'c';;
List.mem 2 automata.accepting;;

match_word automata ['a'];;
match_word automata "c";;
match_word automata "bc";;
match_word automata ['b';'b';'b';'c'];;
match_word automata ['b';'b';'b';'c';'c'];; (* should not !*)
match_word automata "bac";;
match_word automata "bca";;  (* should not !*)
match_word automata "cb";;  (* should not !*)
match_word automata "bca";; (* should not !*)
match_word automata "";;

is_complete automata ;;
is_complete (complete automata);;


let cautomata = (complete automata);;
match_word automata ['a'];;
match_word cautomata ['c'];;
match_word cautomata "bc";;
match_word cautomata ['b';'b';'b';'c'];;
match_word cautomata ['b';'b';'b';'c';'c'];; (* should not !*)
match_word cautomata "bac";;
match_word cautomata "bca";;  (* yes !*)
match_word cautomata "cb";;  (* yes !*)
match_word cautomata "bca";; (* yes !*)
match_word cautomata "";;


automata;;
complement(automata);;
complement(complete automata);;

is_complete (complement(automata));;
is_complete (complement (complete automata));;

succ automata  0;;
succ automata  2;;
succ automata  1;;


fsm_to_graph automata;;
accessible_states (complement (complete automata));;
fsm_to_graph automata;;
switch_direction (fsm_to_graph automata);;
coaccessible_states (complete automata);;
is_finite_language automata;;
is_finite_language (complete automata);;



let fdelta prev letter =
    match (prev, letter) with
        | (0,'a') -> Some 1
        | (0,'c') -> Some 1
        | (0,'b') -> Some 2
        | (2,'c') -> Some 1
        | _ -> None;;

let fautomata = {states = states;
                alphabet = sigma;
                initial = 0;
                trans_f = fdelta;
                accepting = final_states};;

is_finite_language fautomata;;
