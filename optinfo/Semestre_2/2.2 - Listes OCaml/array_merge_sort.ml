let slice t =
    let n = Array.length t in
    let t1 = Array.init (n/2) (fun i -> t.(i)) and
        t2 = Array.init (n-n/2) (fun i -> t.(n/2 + i)) in 
    (t1,t2);;

(* Avec l'API : Attention en O(n^2) à cause de la concaténation d'array *)
(*let rec merge t1 t2 =
  let n1 = Array.length t1 and
      n2 = Array.length t2 in
  match (n1, n2) with
  | (0,_) -> t2
  | (_,0) -> t1
  | (_,_) -> if t1.(0) < t2.(0)
             then Array.append [|t1.(0)|] (merge (Array.sub t1 1 (n1 - 1)) t2)
             else Array.append [|t2.(0)|] (merge t1 (Array.sub t2 1 (n2 - 1)));;
 *)

(* en O(n) : les begin end et les parenthèses sont nécessaires ! *)
let merge t1 t2 =
  let n1 = Array.length t1 and
      n2 = Array.length t2 and
      i1 = ref 0 and i2 = ref 0 in
  let n = n1 + n2 in 
  let t = Array.make n 0 in
  for k = 0 to n - 1 do
    if !i1 >= n1 then (t.(k) <- t2.(!i2);incr i2)
    else begin
        if !i2 >= n2
        then (t.(k) <- t1.(!i1);incr i1)
        else begin
              if t1.(!i1) < t2.(!i2)
              then (t.(k) <- t1.(!i1);incr i1)
              else (t.(k) <- t2.(!i2);incr i2)
             end
         end
  done;
  t;;
 

let rec merge_sort t =
  let n = Array.length t in
  match n with
  | 1 -> t
  | _ -> let (t1, t2) = slice t in
         merge (merge_sort t1) (merge_sort t2);;


(* tests *)

let t = [|3;9;0;1;7;4;5;2;6|];;
slice t;;
merge [|0;1;3;9|]  [|2;4;5;6;7|];; 
merge_sort t;;
