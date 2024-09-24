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

let creer_file_priorites n (v,p) = {taille = 0; tas = Array.init n (fun _ -> {valeur = v; priorite=p})};;

let inserer filep (v,p) =
  let size = Array.length filep.tas in
  if filep.taille + 1 > size then failwith "FULL_PRIORITY_QUEUE";
  filep.tas.(filep.taille) <- {valeur=v; priorite=p};
  faire_monter filep.tas filep.taille;
  filep.taille <- filep.taille + 1;;

let retirer_minimum filep =
  if filep.taille = 0 then failwith "EMPTY_PRIORITY_QUEUE";
  let premier = filep.tas.(0) in
    filep.taille <- filep.taille - 1;
    filep.tas.(0) <- filep.tas.(filep.taille);
    faire_descendre filep.tas filep.taille 0;
    premier;;


(* TEST *)

let filep = creer_file_priorites  10 (-1, max_int);; 
for i = 0 to 9 do inserer filep (i, 10-i) done;;
filep;;
retirer_minimum filep;;
filep;;
inserer filep (10, 11);;
filep;;
inserer filep (-11, 4);;
filep;;

let filep = creer_file_priorites 10 (-1, max_int);;
Random.init 54;;
for k=0 to 9 do
        let v = Random.full_int 100 and p = Random.full_int 100 in
        inserer filep (v,p);
    done;;
filep;;
for k = 0 to 10 do 
    let m = retirer_minimum filep in
    Printf.printf "min --> (%i, %i)\n" m.valeur m.priorite 
done;;
filep;;
