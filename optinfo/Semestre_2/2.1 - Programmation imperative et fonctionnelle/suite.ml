let next u = u - 1;; (* formulation récurrente de la suite *)

let u u0 n = (* for loop *)
    let u = ref u0 in
    for i = 1 to n do
        u := next !u
    done;
    !u;;

u 0 10;;

let u u0 n =  (* while loop *)
    let u = ref u0 and k = ref 0 in
    while !k < n do
        u := next !u;
        incr k  (* identique à k := !k + 1 *)
    done;
    !u;;

u 0 10;;

let rec u u0 n =
    if n = 0
    then u0
    else u (next u0) (n-1);;

u 0 10;;

let u u0 n = (* pattern matching *)
    match n with
    | 0 -> u0
    | _ -> u (next u0) (n-1);;

u 0 10;;


let next u = if (u mod 2) = 1 then 3 * u + 1 else u / 2 ;; (* suite de syracuse *)

let u u0 n = (* filtrage de motif *)
    match n with
    | 0 -> u0
    | _ -> u (next u0) (n-1);;
u 17 12;;

let syracuse u0 =
   let u = ref u0 and n = ref 0 in
      while !u > 1 do
        u := next !u;
        incr n
        (* identique à --> n := !n + 1 *)
      done;
      !n;;

next 3;;
syracuse 3;;
syracuse 17;;
syracuse 97;;

let next u = if (u mod 2) = 1 then 3 * u + 1 else u / 2 ;;
let syracuse u0 = (* version récursive *)
    let rec count uk k =
        match uk with
            | 1 -> uk, k
            | _ -> count (next uk) (k+1)
    in count u0 0;;

syracuse 3;;
syracuse 17;;
syracuse 97;;