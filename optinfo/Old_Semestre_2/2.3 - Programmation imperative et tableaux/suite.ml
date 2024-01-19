let next u = 2*u -3;;

let un u0 n =
    let u = ref u0 in
    for i = 1 to n do
        u := next !u
    done;
    !u;;

let un u0 n =
    let u = ref u0 and k = ref 0 in
    while !k < n do
        u := next !u;
        incr k
    done;
    !u;;

un 0 10;;

let next_u u = if (u mod 2) = 1 then 3 * u + 1 else u / 2 ;;

let syracuse u0 =
   let u = ref u0 and n = ref 0 in
      while !u > 1 do
        u := next_u !u;
        incr n
        (* same as --> n := !n + 1 *)
      done;
      !n;;


(* MAIN PROGRAM *)
next_u 3;;

syracuse 3;;
syracuse 17;;
syracuse 97;;
