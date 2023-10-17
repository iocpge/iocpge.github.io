let tarjan_scc g =
  let n = Array.length g in
  let index = Array.make n (-1) in
  let lowlink = Array.make n (-1) in
  let on_stack = Array.make n false in
  let stack = ref [] in
  let cc_list = ref [] in
  let current_index = ref 0 in
    (* TODO *)
  !cc_list;;

(* TESTS *)
let g = [|
    [1];         (*  0 *)
    [2; 3];      (*  1 *)
    [0];         (*  2 *)
    [4];         (*  3 *)
    [5];         (*  4 *)
    [3; 6];      (*  5 *)
    [7];         (*  6 *)
    [5; 8];      (*  7 *)
    [6];         (*  8 *)
  |];;

let sccs = tarjan_scc g;;

let g2 = [|
    [1];         (*  0 *)
    [2; 3];      (*  1 *)
    [0;3];       (*  2 *)
    [7];         (*  3 *)
    [3];         (*  4 *)
    [4;6];       (*  5 *)
    [5];         (*  6 *)
    [4; 8; 9];   (*  7 *)
    [];          (*  8 *)
    [8];         (*  9 *)
  |];;

let sccs2 = tarjan_scc g2;;
