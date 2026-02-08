let echanger t i j =
  let tmp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- tmp

let index_du_plus_petit t k =
  let n = Array.length t in
  let imin = ref k in
  for i = k + 1 to n - 1 do
    if t.(i) < t.(!imin) then imin := i (* L'affectation est bien une instruction () unit *)
  done;
  !imin

let tri_selection t =
  let n = Array.length t in
  for k = 0 to n - 1 do
    let imin = index_du_plus_petit t k in
    echanger t k imin
  done

(* TESTS *)
let a = [| 9; 0; 4; 5; 1; 3; 2; 7 |];;

a;;
tri_selection a;;
a
