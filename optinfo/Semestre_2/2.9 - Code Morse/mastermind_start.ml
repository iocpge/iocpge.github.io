type pion = Rouge | Vert | Jaune | Bleu | Orange | Noir | Inconnu

type indication = O | N | C  

type etat = {
  solution: pion array;
  propositions : pion array list;
  indications : indication array list;
  gagne : bool; 
}

let nbcouleurs = 6;;
let nbpions = 4;;
let nbcoups = 10;;

let string_to_pion_array s = 
    let n = String.length s in
    let a = Array.make n Inconnu in 
    for k = 0 to n - 1 do 
      match s.[k] with 
      | 'R' -> a.(k) <- Rouge
      | 'V' -> a.(k) <- Vert 
      | 'J' -> a.(k) <- Jaune 
      | 'B' -> a.(k) <- Bleu 
      | 'O' -> a.(k) <- Orange 
      | 'N' -> a.(k) <- Noir 
      |  _ -> failwith "Unknown Color Error"
    done;
    a;;

let pion_array_to_string a =
  let n = Array.length a in
  let s = ref ""  in 
  for k = 0 to n - 1 do
    match a.(k) with 
      | Rouge -> s := !s ^ "R"
      | Vert -> s := !s ^ "V" 
      | Jaune  -> s := !s ^ "J" 
      | Bleu -> s := !s ^ "B" 
      | Orange -> s := !s ^ "O" 
      | Noir -> s := !s ^ "N" 
      |  _ -> failwith "Unknown Color Error"
  done;
  !s;;

let string_of_pion = function
  | Rouge -> "Rouge"
  | Vert -> "Vert"
  | Jaune -> "Jaune"
  | Bleu -> "Bleu"
  | Orange -> "Orange"
  | Noir -> "Noir"
  | Inconnu -> "Inconnu"

let string_of_indication = function
  | N -> "N"
  | O -> "O"
  | C -> "C"

let print_pions pions =
  Array.iter (fun p -> Printf.printf "%s " (string_of_pion p)) pions

let print_indications indications =
  Array.iter (fun i -> Printf.printf "%s " (string_of_indication i)) indications

let rec fusion lst1 lst2 =
  match (lst1, lst2) with
  | ([], _) | (_, []) -> []
  | (x::xs, y::ys) -> (x, y) :: (fusion xs ys)

let print_etat etat =
  Printf.printf "Solution: ";
  print_pions etat.solution;
  print_newline ();
  Printf.printf "Propositions: \t Indications\n";
  let f = fusion etat.propositions etat.indications in
  let size = List.length f in 
  List.iteri
    (fun i (prop, ind) -> Printf.printf "#%d :\t" (nbcoups - size + i + 1);
                       print_pions prop;
                       Printf.printf "\t";
                       print_indications ind;
                       print_newline ();
    ) f;
  print_newline ();
  Printf.printf "Gagne: %b\n" etat.gagne


let random_color () =
  let r = Random.int nbcouleurs in
  match r with
  | 0 -> Rouge
  | 1 -> Vert
  | 2 -> Jaune
  | 3 -> Rouge
  | 4 -> Bleu
  | 5 -> Orange
  | 6 -> Noir
  | _ -> failwith "Pion Error";;

let generate_code () = ();; (* TODO : generate_code : unit -> pion array *)

let player_guess state  = ();; (* TODO : player_guess : etat -> etat  *)

let indicate prop sol = ();; (* TODO indicate : 'a array -> 'a array -> indication array *)

let feedback state = ();; (* TODO feedback : etat -> etat *)

let play () =
  let code = generate_code () in
  let state = ref {solution=code;propositions=[];indications=[];gagne=false} in
  while not !state.gagne && List.length !state.propositions < nbcoups do
    state := feedback (player_guess !state);
    print_etat !state;
  done;
  if !state.gagne
  then Printf.printf  "Gagné ! Le mot était %s." (pion_array_to_string !state.solution)
  else Printf.printf  "Perdu ! Le mot était %s" (pion_array_to_string !state.solution);;

play ();;
