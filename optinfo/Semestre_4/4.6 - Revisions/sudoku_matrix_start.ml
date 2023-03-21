let telegram = [|  [| 8; 0; 9; 0; 0; 0; 0; 0; 7|];
                   [| 0; 0; 0; 5; 0; 9; 0; 0; 0|];
                   [| 0; 3; 5; 0; 7; 0; 8; 9; 0|];
                   [| 0; 2; 0; 7; 0; 8; 0; 1; 0|];
                   [| 7; 0; 0; 0; 0; 0; 0; 0; 2|];
                   [| 0; 6; 0; 1; 0; 5; 4; 7; 0|];
                   [| 0; 9; 7; 8; 5; 4; 2; 3; 0|];
                   [| 0; 0; 0; 9; 0; 6; 7; 0; 0|];
                   [| 5; 0; 0; 0; 0; 0; 0; 0; 6 |]
|];;

let all_done = [|[|1; 2; 3; 4; 5; 6; 7; 8; 9|];
                 [|4; 5; 6; 7; 8; 9; 1; 2; 3|];
                 [|7; 8; 9; 1; 2; 3; 4; 5; 6|];
                 [|2; 3; 4; 5; 6; 7; 8; 9; 1|];
                 [|5; 6; 7; 8; 9; 1; 2; 3; 2|];
                 [|8; 9; 1; 2; 3; 4; 5; 6; 7|];
                 [|3; 4; 5; 6; 7; 8; 9; 1; 2|];
                 [|6; 7; 8; 9; 1; 2; 3; 2; 5|];
                 [|9; 1; 2; 3; 4; 5; 6; 7; 8|]
               |];;

let multiple = [|[|8; 0; 9; 0; 0; 0; 0; 0; 7|];
     [|0; 7; 6; 0; 8; 9; 0; 0; 0|];
     [|0; 3; 0; 0; 7; 0; 8; 9; 0|];
     [|0; 2; 0; 7; 0; 8; 0; 1; 0|];
     [|7; 0; 0; 0; 0; 0; 0; 0; 2|];
     [|0; 6; 0; 1; 2; 0; 4; 7; 0|];
     [|6; 9; 7; 8; 0; 4; 2; 3; 1|];
     [|0; 0; 0; 9; 0; 6; 7; 0; 0|];
     [|0; 0; 0; 0; 0; 7; 9; 0; 6|]
     |];;

let n = 9;;

let show sudoku =
  let print_elem e =  if e > 0 then (print_int e; print_string " ") else print_string ". " in
  let print_line line = print_newline (); Array.iter print_elem line in
  print_newline (); Array.iter print_line sudoku; print_newline ();;

show telegram;;
show multiple;;

(* vérifier si la ligne de la case (de numéro [0..80]) contient le chiffre (number) *)
(* val in_row : int -> 'a -> 'a array array -> bool = <fun> *)
let in_row case number board = 0;; (* TODO *)
in_row 77 7 telegram;;
in_row 77 5 telegram;;
in_row 77 6 telegram;;

(* vérifier si la colonne de la case (de numéro [0..80]) contient le chiffre (number) *)
(* val in_col : int -> 'a -> 'a array array -> bool = <fun> *)
let in_col case number board = 0;; (* TODO *)
in_col 11 3 telegram;;
in_col 11 6 telegram;;
in_col 11 7 telegram;;
in_col 11 5 telegram;;
in_col 11 9 telegram;;

(* vérifier si le block 3x3 de la case (de numéro [0..80]) contient le chiffre (number) *)
(* val in_block : int -> 'a -> 'a array array -> bool = <fun> *)
let in_block case number board = 0;;
in_block 77 2 telegram;;
in_block 77 1 telegram;;
in_block 77 9 telegram;;
in_block 77 4 telegram;;

(* Peut-on placer le chiffre number dans la case (de numéro [0..80]) ? *)
(* val is_valid_number : int -> 'a -> 'a array array -> bool = <fun> *)
let is_valid_number case number board =  0;; (* TODO *)

(* Résolution du sudoku : backtracking *)
let sudoku board = 
  let sol_nb = ref 0 in
  let rec backtrack c b =
    match c with
    |  81  -> (incr sol_nb; print_string "Solution #"; print_int !sol_nb; show b)
    |  _   ->  () (* TODO *)
  in backtrack 0 board;;

sudoku telegram;;
sudoku multiple;;
sudoku all_done;;
