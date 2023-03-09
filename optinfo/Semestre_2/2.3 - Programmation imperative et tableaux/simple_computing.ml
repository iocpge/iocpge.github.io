(* Suite de Fibonacci : u0 = 0, u1 = 1 *)
let fib n =
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> let u = ref 0 and next_u = ref 1 in
         for i = 2 to n do
           let tmpu = !next_u in
           next_u := !next_u + !u;
           u := tmpu;
           Printf.printf "%d\n" !next_u;
         done;
         !next_u;;
fib 10;;
(* complextié en O(n) *)

let rec rfib n =
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> rfib (n-1) + rfib (n-2);;

rfib 10;;
(* complexité : c(n) = c(n-1) + c(n-2) = ((1+sqrt(5))/2)^n *)

(* Une suite qui tend vers SQRT(a) u_(n+1) = (u_n  + a/u_n)/2 *)
let un a n =
  match n with
  | 0 -> 1.
  | _ -> let u = ref 1. and i = ref 0 in
         while !i < n do
           u := 0.5 *. (a /. !u +. !u);
           incr i;
         done;
         !u;;

un 2. 100;;

(* array : maximum d'un tableau *)

let vmax t =
  let n = Array.length t in
  let m = ref t.(0) in
  for i = 1 to n - 1 do
     if t.(i) > !m then m := t.(i)
  done;
  !m;;

let a = [|9;5;42;1;3;0;-65|];;
vmax a;;
let av = [||];;
vmax av;;

(* maximum d'un tableau d'entiers, retour de type int option *)
let ovmax t =
  let n = Array.length t in
  if n = 0 then None else
    begin
      let m = ref t.(0) in
      for i = 1 to n - 1 do
        if t.(i) > !m then m := t.(i)
      done;
      Some !m;
  end;;

ovmax a;;
ovmax av;;

(* moyenne des valeurs d'un tableau *)
let average t =
  let n = Array.length t in
  let m = ref 0. in
  for i = 0 to n - 1 do
    m := !m +. t.(i)
  done;
  !m /. float(n);;

let ad = [|1. ;3.4; 5.7; 43.4; 0.456; 6.421|];;
let adv = [||];;
average ad;;
average adv;;

(* écart type des valeurs d'un tableau *)
let stddev t =
  let n = Array.length t in
  let m = average t in
  let e = ref 0. in 
  for i = 0 to n - 1 do
    let d = t.(i) -. m in
        e := !e  +. (d *. d)
  done;
  sqrt (!e /. float(n));;

stddev ad;;

(* renvoyer un tuple  : mettre les parenthèses  *)
let mstd t =
  let n = Array.length t in
  let m = average t in
  let e = ref 0. in 
  for i = 0 to n - 1 do
    let d = t.(i) -. m in
    e := !e  +. (d *. d)
  done;
  (m,sqrt (!e /. float(n)));;

let (m, ec) = mstd ad;; (* parenthèses également pour la déconstruction du tuple *)
