type 'a qdata = {valeur: 'a; priorite: int};;
type 'a file_priorites = {mutable taille: int; tas: 'a qdata array};;

let echanger t i j = let tmp = t.(i) in t.(i) <- t.(j); t.(j) <- tmp;;

let rec faire_monter tas k = match k with
    | 0 -> ()
    | _ -> let p = (k - 1)/2 in
           if tas.(k).priorite < tas.(p).priorite
           then (echanger tas k p ; faire_monter tas p);;

let rec faire_descendre tas taille k = match k with
    | n when 2*n + 1 >= taille -> ()
    | n when 2*n + 1 = (taille - 1) ->
       if tas.(n).priorite > tas.(2*n + 1).priorite
       then echanger tas (2*n + 1) n
    | n -> begin
            let f = if tas.(2*n + 1).priorite < tas.(2*n + 2).priorite then  2*n +  1 else 2*n + 2 in
            if tas.(n).priorite > tas.(f).priorite then (echanger tas n f; faire_descendre tas taille f;)
          end;;

let creer_file_priorites n (v,p) = (* TODO *) ();;

let inserer filep (v,p) = (* TODO *) ();;

let retirer_minimum filep = (* TODO *) ();;


(* TEST *)

