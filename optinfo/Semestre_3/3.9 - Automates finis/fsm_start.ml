type fsm = { states : int list;
             alphabet : char list;
             initial : int;
             trans_f : int -> char -> int option;
             accepting : int list};;

let up_to a word =
    let rec aux q size =
        match size with
            | k when k = String.length word -> q  (* done *)
            | k -> let next = a.trans_f q word.[k] in
                        match next with
                            | None -> q
                            | Some(nq) -> aux nq (k+1)
    in aux a.initial 0;;

let match_word a word =
    let final_state = up_to a word in
        List.mem final_state a.accepting;;

let is_complete a =
    let check_letter q letter =
        match  a.trans_f q letter with
               | None -> false
               | Some(_) -> true in
    let rec check_state q alpha =
        match alpha with
            | [] -> true
            | c::t -> if check_letter q c then check_state q t else false in
    let rec check s =
        match s with
            | [] -> true
            | q::t -> if check_state q a.alphabet then check t else false
    in check a.states;;

let complete a =
     if not (is_complete a)
     then
        begin
            let well = List.length a.states in (* le puits ! *)
            let new_trans_f prev letter =
                match a.trans_f prev letter with
                    | None -> Some(well)
                    | Some(next) -> Some(next) in
            { states = (well::a.states);
              alphabet = a.alphabet;
              initial = a.initial;
              trans_f = new_trans_f;
              accepting = a.accepting}
        end
     else a;;

let complement a =
    {states = a.states;
     alphabet = a.alphabet;
     initial = a.initial;
     trans_f = a.trans_f;
     accepting = List.filter (fun q -> not (List.mem q a.accepting)) a.states};;

(* TODO *)
let succ a q = [];;


(* TODO *)
let fsm_to_graph a = [||];;


(* TODO *)
let accessible_states a = [];;

(* TODO *)
let switch_direction g = [||];;

(* TODO *)
let coaccessible_states a = [];;

(* TODO *)
let dfs g v0 = true ;;

(* TODO *)
let is_finite_language a = true;;


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