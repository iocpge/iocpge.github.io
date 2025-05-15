type 'a qdata = {valeur: 'a; priorite: int};;
type 'a file_priorites = {mutable taille: int; tas: 'a qdata array};;

let echanger t i j = let tmp = t.(i) in t.(i) <- t.(j); t.(j) <- tmp;;

let rec faire_monter tas k = match k with
    | 0 -> ()
    | _ -> let p = (k - 1)/2 in
           if tas.(k).priorite < tas.(p).priorite
           then (echanger tas k p ; faire_monter tas p);;

let rec faire_descendre tas taille k = match k with
    | n when 2*n + 1 >= taille -> () (* pas d'enfants *)
    | n when 2*n + 1 = (taille - 1) -> (* un seul enfant *)
       if tas.(n).priorite > tas.(2*n + 1).priorite
       then echanger tas (2*n + 1) n
    | n -> begin (* deux enfants *)
            let f = if tas.(2*n + 1).priorite < tas.(2*n + 2).priorite then  2*n +  1 else 2*n + 2 in
            if tas.(n).priorite > tas.(f).priorite then (echanger tas n f; faire_descendre tas taille f;)
          end;;

let creer_file_priorites n (v,p) = {taille = 0; tas = Array.init n (fun _ -> {valeur = v; priorite=p})};;

let inserer filep (v,p) =
  let size = Array.length filep.tas in
  if filep.taille + 1 > size then failwith "FULL_PRIORITY_QUEUE";
  filep.tas.(filep.taille) <- {valeur=v; priorite=p}; (* Placer l'élément à la fin *)
  faire_monter filep.tas filep.taille; (* recréer la structure de tas *)
  filep.taille <- filep.taille + 1;; 

let retirer_minimum filep =
  if filep.taille = 0 then failwith "EMPTY_PRIORITY_QUEUE";
  let premier = filep.tas.(0) in (* sauvegader l'élément le plus prioritaire *)
    filep.taille <- filep.taille - 1; 
    filep.tas.(0) <- filep.tas.(filep.taille);  (* Placer le dernier élément au sommet *)
    faire_descendre filep.tas filep.taille 0;   (* Recréer la structure de tas *)
    premier;;   (* renvoyer le résultat *)


let prim g start =
  (* INITIALISATION *)
  let n = Array.length g in
  let p_min = Array.make n max_int in (* poids min vers chaque sommet *)
  let parents = Array.make n max_int in (* connaître le parent d'un sommet dans l'arbre *)
  let selected = Array.make n false in (* savoir si un sommet est dans S *)
  let pq = creer_file_priorites 50 (max_int,max_int) in
  parents.(start) <- -1;  (* personne n'est parent de start dans l'arbre *)
  p_min.(start) <- 0; 
  inserer pq (start, p_min.(start));
  let count = ref 0 in (* pour faire exactement n itérations *)
  (* PROCESS *)
  while !count < n do
      let u = (retirer_minimum pq).valeur in
      selected.(u) <- true; (* insérer u est dans S *)
      let update (v,poids) = if not selected.(v) then (* v n'est pas dans S *)
                      begin
                          if 	poids < p_min.(v) (* si plus léger *)
                          then (p_min.(v) <- poids; parents.(v) <- u; inserer pq  (v, poids)) 
                              (* mettre à jour le poids min et la file *)
                      end;
      in List.iter update g.(u); (* pour chaque voisin de u, mettre à jour les distance et la file *)
      incr count;
  done;
  (parents, Array.fold_left (+) 0 p_min);;



let gex = [| [(1,1);(2,2);(3,1);(5,5)];
             [(0,1);(2,1)];
             [(0,2);(1,1);(3,2);(4,3)];
             [(0,1); (2,2); (4,2);(5,3);(6,4)];
             [(2,3); (3,2); (6,1)];
             [(0,5); (3,3); (6,3)];
             [(3,4);(4,1);(5,3)] |];;


prim gex 0;;
prim gex 1;;
prim gex 2;;
prim gex 3;;
prim gex 4;;
prim gex 5;;
prim gex 6;;

