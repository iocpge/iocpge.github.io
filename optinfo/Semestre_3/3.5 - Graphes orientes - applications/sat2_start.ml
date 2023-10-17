let floyd_warshall m = (* TODO *) m ;;

let is_inf x = x = max_int;;

let check_sat2 m = (* TODO *) true;;

(*
a -> 0
b -> 1
c -> 2
not a -> 3
not b -> 4
not c -> 5
*)

let mf2 = [|[|0; 1; max_int; max_int; 1; max_int |] ;
            [|1; 0; max_int; 1; max_int; max_int|] ;
            [|1; max_int; 0; max_int; max_int; max_int|] ;
            [|max_int; max_int; max_int; 0; 1; 1|];
            [|max_int; max_int; max_int; 1; 0; max_int|];
            [|max_int; max_int; max_int; max_int; max_int; 0|];
        |] ;;

let mf2_mod = [|[|0; 1; max_int; max_int; 1; max_int |] ;
                [|1; 0; max_int; 1; max_int; max_int|] ;
                [|1; max_int; 0; max_int; max_int; max_int|] ;
                [|max_int; 1; max_int; 0; 1; 1|];
                [|1; max_int; max_int; 1; 0; max_int|];
                [|max_int; max_int; max_int; max_int; max_int; 0|];
            |] ;;

check_sat2 (floyd_warshall mf2);;
check_sat2 (floyd_warshall mf2_mod);;