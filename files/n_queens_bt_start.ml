let show board =
  let print_row v =
    for i = 0 to (List.length board) - 1 do
      print_string (if i=v then "\u{2655} " else ". ");
    done;
    print_newline()
  in List.iter print_row board; print_newline();;

(* TESTS *)
let n = 4;;
let test_board = [2;0;3;2];;
show test_board;;

let rec_show board = (* TODO *);;

let same_col c board = (* TODO Y-a-t-il déjà une reine sur la colonne c ? *);;

let rec rec_same_col c board = (* TODO Y-a-t-il déjà une reine sur la colonne c ? *);;

let same_row r board = (* TODO Y-a-t-il déjà une reine sur la ligne r ? *);;

let rec_same_row r board = (* TODO Y-a-t-il déjà une reine sur la ligne r ?*);;

let up_diag r c board = (* TODO Y-a-t-il déjà une reine sur la diagonale montante de la case r c ?*);;

let down_diag r c board = (* TODO Y-a-t-il déjà une reine sur la diagonale descendante de la case r c ?*);;

let under_attack r c board =
  let masked =
   let rec map b row = 
      match b with
        | [] -> []
        | col::tail -> if (row,col) = (r,c) then -1::(map tail (row + 1)) else col::(map tail (row + 1))
    in map board 0
  in same_row r masked || same_col c masked || up_diag r c masked  || down_diag r c  masked;;

let valid_solution board =
    let rec check row b = match b with
        | [] -> true
        | col::tail -> if under_attack row col board then false else check (row + 1) tail
    in  check 0 board;;

let raw_force_4_queens () =
  let board = []
  in for i=0 to n - 1 do
        let bi = i::board in
        for j=0 to n - 1 do
          let bij = j::bi in
          for k=0 to n - 1 do
            let bijk = k::bij in
            for l=0 to n - 1 do
              let bijkl = l::bijk in
                  if valid_solution bijkl then (Printf.printf "[%i,%i,%i,%i]\n" i j k l; rec_show bijkl;)
            done;
          done;
        done;
      done;;


(* TESTS *)
let n = 4;;
let test_board = [2;0;3;2];;
let valid_board = [2;0;3;1];;
let attack_test_board = [2;-1;3;-1];;

show test_board;;
raw_force_4_queens();;