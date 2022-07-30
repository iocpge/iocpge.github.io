let telegram = [|   8; 0; 9; 0; 0; 0; 0; 0; 7;
                    0; 0; 0; 5; 0; 9; 0; 0; 0;
                    0; 3; 5; 0; 7; 0; 8; 9; 0;
                    0; 2; 0; 7; 0; 8; 0; 1; 0;
                    7; 0; 0; 0; 0; 0; 0; 0; 2;
                    0; 6; 0; 1; 0; 5; 4; 7; 0;
                    0; 9; 7; 8; 5; 4; 2; 3; 0;
                    0; 0; 0; 9; 0; 6; 7; 0; 0;
                    5; 0; 0; 0; 0; 0; 0; 0; 6
|];;

let all_done = [|1; 2; 3; 4; 5; 6; 7; 8; 9;
4; 5; 6; 7; 8; 9; 1; 2; 3;
7; 8; 9; 1; 2; 3; 4; 5; 6;
2; 3; 4; 5; 6; 7; 8; 9; 1;
5; 6; 7; 8; 9; 1; 2; 3; 2;
8; 9; 1; 2; 3; 4; 5; 6; 7;
3; 4; 5; 6; 7; 8; 9; 1; 2;
6; 7; 8; 9; 1; 2; 3; 2; 5;
9; 1; 2; 3; 4; 5; 6; 7; 8
|];;

let multiple = [|8; 0; 9; 0; 0; 0; 0; 0; 7;
     0; 7; 6; 0; 8; 9; 0; 0; 0;
     0; 3; 0; 0; 7; 0; 8; 9; 0;
     0; 2; 0; 7; 0; 8; 0; 1; 0;
     7; 0; 0; 0; 0; 0; 0; 0; 2;
     0; 6; 0; 1; 2; 0; 4; 7; 0;
     6; 9; 7; 8; 0; 4; 2; 3; 1;
     0; 0; 0; 9; 0; 6; 7; 0; 0;
     0; 0; 0; 0; 0; 7; 9; 0; 6
     |];;


let n = 9;;     
let rec_show sudoku =
  let rec aux i b = match b with 
   |  [] -> print_string "\n"
   |  v :: t -> if i mod n = 0 then print_newline (); if v = 0 then print_string "." else print_int v; print_string " "; aux (i + 1) t 
  in aux 0 sudoku;;

let show sudoku = 
  let pl i v = if i mod n = 0 then print_newline (); if v = 0 then print_string "." else print_int v; print_string " ";
in Array.iteri (pl) sudoku; print_newline ();;
show telegram;;

let in_row i number board =
  let row_number = i / n in
  let row = Array.sub board (row_number * n) n  in
  Array.mem number row;;   
in_row 8 7 telegram;;

let in_col i number board = 
  let col_number = i mod n in
  let col =  List.filteri (fun index element -> col_number = index mod n ) (Array.to_list board) in
  List.mem number col;;
let in_block i number board =
  let row_number = i / n in
  let col_number = i mod n in
  let row_block =  (row_number / 3) * 3 in
  let col_block =   (col_number / 3) * 3 in
  let check index element = index / n   >= row_block  &&
                            index / n   <  row_block + 3 &&
                            index mod n >= col_block &&
                            index mod n <  col_block +3  in 
  let block =  List.filteri check (Array.to_list board) in
  List.mem number block;;
let is_valid_number i number board = not (in_row i number board) && not (in_col i number board) && not (in_block i number board);;

let sudoku board = 
  let sol_nb = ref 0 in
  let rec aux index b = match index with
  |  81  -> (incr sol_nb; print_string "Solution #"; print_int !sol_nb; show b)
  |  _   -> if b.(index) > 0 then aux (index + 1) b 
            else (for number = 1 to 9 do 
                    if is_valid_number  index  number b 
                      then (b.(index) <- number; aux (index + 1) b; b.(index) <- 0;) 
                  done)    
  in aux 0 board;; 

sudoku telegram;;
let multiple = [|8; 0; 9; 0; 0; 0; 0; 0; 7;
     0; 7; 6; 0; 8; 9; 0; 0; 0;
     0; 3; 0; 0; 7; 0; 8; 9; 0;
     0; 2; 0; 7; 0; 8; 0; 1; 0;
     7; 0; 0; 0; 0; 0; 0; 0; 2;
     0; 6; 0; 1; 2; 0; 4; 7; 0;
     6; 9; 7; 8; 0; 4; 2; 3; 1;
     0; 0; 0; 9; 0; 6; 7; 0; 0;
     0; 0; 0; 0; 0; 7; 9; 0; 6
     |];;

sudoku multiple;;
