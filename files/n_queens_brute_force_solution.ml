let show board =
  let print_row v =
    for i = 0 to (List.length board) - 1 do
      print_string (if i=v then "\u{2655} " else ". ");
    done;
    print_newline()
  in List.iter print_row board; print_newline();;

let rec_show board =
  let print_row col =
        for c = 0 to (List.length board) - 1 do
            if col = c then print_string "\u{2655} " else print_string ". " done; print_newline()
  in let rec aux b = match b with
              | [] -> print_newline()
              | col::t -> print_row col; aux t;
  in aux board;;

let same_col c board = List.mem c board;;

let rec rec_same_col c board = match board with
    | [] -> false
    | head::tail -> if c = head then true else rec_same_col c tail;;

let same_row r board = (List.nth board r) != -1;;

let rec_same_row r board =
    let rec aux b i = match b with
        | [] -> false
        | head::tail -> if i = r && head != -1 then true else aux tail (i + 1)
        in aux board 0;;

let up_diag r c board =
  let rc = r + c
    in let rec diag b i = match b with
        | [] ->  false
        | head::tail -> if head != -1 then if (i + head) = rc then true else diag tail (i + 1) else diag tail (i + 1)
    in diag board 0;;

let down_diag r c board =
  let rc = r - c
    in let rec diag b row = match b with
        | [] ->  false
        | col::tail -> if col != -1 then if (row - col) = rc then true else diag tail  (row + 1) else diag tail (row + 1)
  in diag board 0;;

let under_attack r c board = 
  let masked = List.mapi (fun index elem -> if r = index && c = elem then -1 else elem) board 
      in same_row r masked || same_col c masked || up_diag r c masked  || down_diag r c  masked;;

let rec_under_attack r c board =
  let masked =
   let rec aux b row = match b with
        | [] -> []
        | col::tail -> if (row,col) = (r,c) then -1::(aux tail (row + 1)) else col::(aux tail (row + 1))
        in aux board 0
  in same_row r masked || same_col c masked || up_diag r c masked  || down_diag r c  masked;;

let valid_solution board =
  let res = List.mapi (fun r c -> under_attack r c board) board
    in not (List.mem true res);;

let rec_valid_solution board =
    let rec check row b = match b with
        | [] -> true
        | col::tail -> if under_attack row col board then false else check (row + 1) tail
    in  check 0 board;;

let raw_force_4_queens () =
  let n = 4 and board = []
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

let rec rm x my_list = match my_list with 
  | [] -> []
  | h::t -> if h=x then rm x t else  h::rm x t;;

let rm x my_list = List.filter ((!=) x) my_list;;

let create_board s =
    let rec aux l i = if s=i then l else i::(aux l (i + 1))
    in aux [] 0;;

let create_board s = List.init s (fun x -> x);;

(* Fixed-head solution*)
let rec permutations my_list =  match my_list with  
  | [] -> []
  | x::[] -> [[x]]
  | l -> List.fold_left (fun acc x -> acc @ List.map (fun p -> x::p) (permutations (rm x l))) [] l;;


let brute_force_permutation s = 
  let sol_nb = ref 0
    in let print_if_valid b = if valid_solution b then (incr sol_nb; print_string "Solution #"; print_int !sol_nb; print_newline(); rec_show b) 
    in let perms = permutations (create_board s)
    in List.iter print_if_valid perms;;


(* TESTS *)
let n = 4;;
let test_board = [2;0;3;2];;
let valid_board = [2;0;3;1];;
let attack_test_board = [2;-1;3;-1];;

(* show test_board;;
rec_show test_board;;
show test_board;;
show [3;-1;2;-1];; *)

(*rec_same_col 1 test_board;;
rec_same_col 3 test_board;;

same_col 1 test_board;;
same_col 3 test_board;;

same_row 1 test_board;;
same_row 2 test_board;;
same_row 3 test_board;;
same_row 0 test_board;;
same_row 1 [3;-1;2;-1];;
same_row 2 [3;-1;2;-1];;
same_row 3 [3;-1;2;-1];;

show test_board;;
rec_same_row 1 test_board;;
rec_same_row 2 test_board;;
rec_same_row 3 test_board;;
rec_same_row 0 test_board;;
rec_same_row 1 [3;-1;2;-1];;
rec_same_row 2 [3;-1;2;-1];;
rec_same_row 3 [3;-1;2;-1];;


up_diag 0 0 test_board;;
up_diag 3 0 test_board;;
up_diag 0 3 test_board;;
up_diag 3 3 test_board;;
up_diag 2 2 test_board;;
up_diag 0 1 test_board;;
up_diag 1 1 test_board;;

rec_up_diag 0 0 test_board;;
rec_up_diag 3 0 test_board;;
rec_up_diag 0 3 test_board;;
rec_up_diag 3 3 test_board;;
rec_up_diag 2 2 test_board;;
rec_up_diag 0 1 test_board;;
rec_up_diag 1 1 test_board;;


down_diag 0 0 test_board;;
down_diag 3 0 test_board;;
down_diag 0 3 test_board;;
down_diag 3 3 test_board;;
down_diag 2 2 test_board;;
down_diag 0 1 test_board;;
down_diag 1 1 test_board;;
down_diag 2 1 test_board;;

rec_down_diag 0 0 test_board;;
rec_down_diag 3 0 test_board;;
rec_down_diag 0 3 test_board;;
rec_down_diag 3 3 test_board;;
rec_down_diag 2 2 test_board;;
rec_down_diag 0 1 test_board;;
rec_down_diag 1 1 test_board;;
rec_down_diag 2 1 test_board;;

under_attack 0 0 attack_test_board;;
under_attack 1 0 attack_test_board;;
under_attack 1 1 attack_test_board;;
under_attack 1 2 attack_test_board;;
under_attack 1 3 attack_test_board;;
under_attack 0 2 attack_test_board;;
under_attack 3 1 attack_test_board;;
same_row 0 attack_test_board;;
same_row 1 attack_test_board;;
same_row 2 attack_test_board;;
same_row 3 attack_test_board;;
same_col 0 attack_test_board;;
same_col 1 attack_test_board;;
same_col 2 attack_test_board;;
same_col 3 attack_test_board;;
down_diag 3 0 attack_test_board;;
up_diag 3 0 attack_test_board;;
down_diag 3 1 attack_test_board;;
up_diag 3 1 attack_test_board;;


rec_under_attack 0 0 attack_test_board;;
rec_under_attack 1 0 attack_test_board;;
rec_under_attack 1 1 attack_test_board;;
rec_under_attack 1 2 attack_test_board;;
rec_under_attack 1 3 attack_test_board;;
rec_under_attack 0 2 attack_test_board;;
rec_under_attack 3 1 attack_test_board;;

rec_show attack_test_board;;
show attack_test_board;;

valid_solution attack_test_board;;
valid_solution test_board;;
valid_solution valid_board;;

rec_valid_solution attack_test_board;;
rec_valid_solution test_board;;
rec_valid_solution valid_board;;*)

(* raw_force_4_queens();; *)
 

(*
create_board 5;;

permutations (create_board 4);;
permutations (create_board 5);;
permutations (create_board 6);;

brute_force_permutation 4;;
brute_force_permutation 5;;
brute_force_permutation 6;;
brute_force_permutation 7;;*)
(*brute_force_permutation 8;;*)
(* brute_force_permutation 9;; *)
(*brute_force_permutation 12;;*)
