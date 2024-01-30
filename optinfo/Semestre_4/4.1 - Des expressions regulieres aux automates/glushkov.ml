type regexp =    EmptySet
                | Epsilon
                | Letter of char
                | Sum of  regexp * regexp
                | Concat of regexp * regexp
                | Kleene of regexp ;;

type lregexp =    Letter_ind of char * int
                | SumL of  lregexp * lregexp
                | ConcatL of lregexp * lregexp
                | KleeneL of lregexp ;;


let rec linearize_and_count e counter =
    match e with
      | EmptySet -> failwith "Regular expression must not contain EmptySet"
      | Epsilon -> failwith "Regular expression must not contain Epsilon"
      | Letter(a) -> Letter_ind(a, counter), counter + 1
      | Sum(e1,e2) -> let (e3,c) = linearize_and_count e1 counter in let (e4,c2) = linearize_and_count e2 c in SumL(e3,e4), c2
      | Concat(e1,e2) -> let (e3,c) = linearize_and_count e1 counter in let (e4,c2) = linearize_and_count e2 c in ConcatL(e3,e4), c2
      | Kleene(e) -> let (e1,c) = linearize_and_count e counter in KleeneL(e1),c
;;

(* let linearize e = fst(linearize_and_count e 1);; *)
let linearize e = let (linexp, _) = linearize_and_count e 1 in linexp;;

let rec first_letter_prefix e = (* ne peut pas être Epsilon, mais attention au Kleene ! *)
    match e with
      | Letter_ind (a,i) -> [a,i]
      | SumL(e1, e2) -> first_letter_prefix e1 @ first_letter_prefix e2
      | ConcatL(KleeneL(e1), e2) -> first_letter_prefix e1 @ first_letter_prefix e2
      | ConcatL(e1, _) -> first_letter_prefix e1
      | KleeneL(e) -> first_letter_prefix e
    ;;

let rec last_letter_suffix e =
    match e with
      | Letter_ind(a,i) -> [a,i]
      | SumL(e1, e2) -> last_letter_suffix e1 @ last_letter_suffix e2
      | ConcatL(e1, KleeneL(e2)) -> last_letter_suffix e1 @ last_letter_suffix e2
      | ConcatL(_, e2) -> last_letter_suffix e2
      | KleeneL(e) -> last_letter_suffix e
  ;;

let cartesian_product set1 set2 =
  List.fold_left (fun acc e -> acc@ (List.map (fun e' -> (e,e')) set2)) [] set1;;

let cartesian_product set1 set2 =
   let rec assoc e l = (* map *)
        match l with
            | [] -> []
            | h::t -> (e,h):: assoc e t in
   let rec aux set = (* accumulation des map *)
        match set with
            | [] -> []
            | e :: t -> assoc e set2 @ aux t
  in aux set1;;

cartesian_product [1;3;5] [2;4;6;8];;

let rec two_factors e =
    match e with
      | Letter_ind(_,_) -> []
      | SumL(e1, e2) ->  two_factors e1 @ two_factors e2
      | ConcatL(e1, e2) -> let l = two_factors e1 @ two_factors e2
                            in l @ cartesian_product (last_letter_suffix e1) (first_letter_prefix e2)
      | KleeneL(e) -> two_factors e @ cartesian_product (last_letter_suffix e) (first_letter_prefix e)
  ;;


type ndfsm ={ states : int list;
              alphabet : char list;
              initial : int list;
              transitions : (int * char * int) list;
              accepting : int list};;

(*let all_states e = let (_,c) = linearize_and_count e 1 in List.init c (fun i -> i);;*)

let all_states e =
    let (_,c) = linearize_and_count e 1 in
    let states = ref [] in
    for i = c downto 0 do
        states := i :: !states
    done;
    !states;;

let all_states e =
    let (_,c) = linearize_and_count e 1 in
    let rec create states k =
        match k with
         | 0 -> [0]
         | _ -> create (k::states) (k-1)
    in create [] c;;


let accepting_states linexp =
    let rec aux letters =
        match letters with
          |[] -> []
          |(_,n)::t -> n::(aux t) in
    aux (last_letter_suffix linexp);;

let rec initial_transitions p =
    match p with
      |[] -> []
      |(c,n)::t -> (0,c,n)::(initial_transitions t);;

let rec inner_transitions factors =
    match factors with
      |[] -> []
      |((_,n1),(c2,n2))::t -> (n1,c2,n2)::(inner_transitions t);;

let all_transitions e = (initial_transitions (first_letter_prefix e)) @ (inner_transitions (two_factors e));;

(*let rm_dup s = List.fold_left (fun acc x -> if List.mem x acc then acc else x :: acc) [] s;;*)
(*let get_alphabet_from_trans trans =  rm_dup (List.map (fun (_,a,_) -> a) trans);;*)

let get_alphabet_from_trans trans =
    let rec extract_letters transitions =  (* map *)
        match transitions with
        | [] -> []
        | (_,c,_) :: t -> c :: extract_letters t in
    let rec rm_dup acc letters = (* fold left *)
        match letters with
        | [] -> []
        | c :: t -> if List.mem c acc then rm_dup acc t else rm_dup (c :: acc) t in
   rm_dup [] (extract_letters trans);;


let glushkov rexp =
  let (e,c) = (linearize_and_count rexp 1) in
  let t = all_transitions e in
  { states = List.init c (fun i -> i);
    alphabet = get_alphabet_from_trans t;
    initial = [0] ;
    transitions = t;
    accepting = accepting_states e};;

let e = Concat(Kleene(Sum(Letter('a'), Letter('b'))) , Letter('c'));;
all_states e;;
accepting_states (linearize e);;
glushkov e;;

(* NB automate pas forcément déterministe, il se trouve que c'est le cas car expresion linéaire et donc automate local déterministe *)

(* (ab|b)∗ba *)
let e = Concat(Kleene(Sum(Concat(Letter 'a', Letter 'b'), Letter 'b')),Concat(Letter 'b', Letter 'a'));;
all_states e;;
accepting_states (linearize e);;
glushkov e;;

(* (a|b)*c |  b(a|c)* *)
let e = Sum(Concat(Kleene(Sum(Letter('a'), Letter('b'))) , Letter('c')), Concat(Letter('b'),Kleene(Sum(Letter 'a',Letter 'c'))));;
all_states e;;
accepting_states (linearize e);;
glushkov e;;