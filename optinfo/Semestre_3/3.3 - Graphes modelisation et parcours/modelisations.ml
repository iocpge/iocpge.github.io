(* adjacency list *)
let g = [| [1;2] ; [0;3;4] ; [0;5;6] ; [1] ; [1] ; [2] ; [2] |] ;;

let list_to_matrix g =
  let n = Array.length g in
  let matrix = Array.make_matrix n n false in
  let rec read_row neighbours row =
        match neighbours with
            | [] -> ()
            | u::t -> matrix.(row).(u) <- true; read_row t row in
  for v = 0 to n - 1 do
      read_row g.(v) v;
  done;
  matrix ;;

let matrix = list_to_matrix g ;;

let matrix_to_list matrix =
  let n = Array.length matrix in
  let g = Array.make n [] in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      if matrix.(i).(j) then g.(i) <- j::g.(i)
    done;
  done;
  g ;;

matrix_to_list matrix ;;

let desoriented_list g =
  let n = Array.length g in
  let rec symetrize neighbours v =
        match neighbours with
            | [] -> ()
            | u::t -> if not (List.mem v g.(u)) then g.(u) <- v::g.(u); symetrize t v in
  for v = 0 to n - 1 do
        symetrize g.(v) v
  done;;

let g1 = [| [1;2] ; [3;4] ; [5;6] ; [] ; [] ; [] ; [] |] ;;
desoriented_list g1;;
g1;;


let desoriented_matrix m =
  let n = Array.length m in
  for i = 0 to n - 1 do
        for j = i + 1 to n - 1 do
            if m.(i).(j) && (not m.(j).(i)) then m.(j).(i) <- true;
            if m.(j).(i) && (not m.(i).(j)) then m.(i).(j) <- true;
        done ;
 done;;

let g1 = [| [1;2] ; [3;4] ; [5;6] ; [] ; [] ; [] ; [] |] ;;
let m1 = list_to_matrix g1 ;;
desoriented_matrix m1 ;;
m1 ;;
matrix_to_list m1 ;;
