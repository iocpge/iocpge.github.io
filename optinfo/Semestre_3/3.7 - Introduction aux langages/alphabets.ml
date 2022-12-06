let sigma = ["a"; "b"; "c"];; (* Sigma *)

let rec sigma_k alphabet k =
  match k with
    | 0 -> []
    | 1 -> List.map (fun letter -> [letter]) alphabet
    | k -> List.fold_left
            (fun words letter -> words@(List.map (fun word -> letter::word) (sigma_k alphabet (k - 1))))
            [] alphabet
;;
sigma_k sigma 2;;

(*Est- il possible de représenter sigma * avec cette approche ?*)