type 'a file = {
  mutable tete : 'a list;
  mutable queue : 'a list;
}

let filevide () = { tete = []; queue = [] };;

let est_vide file = (file.tete = [] && file.queue = []);;

let enfiler x file = file.queue <-  x :: file.queue;;

let defiler file=
  let rec rev rlst lst =
    match lst with
    | [] -> rlst
    | h :: t -> rev (h::rlst) t in
  match file.tete with
    | [] ->  ( match rev [] file.queue with
                | [] -> failwith "Erreur : file vide !"
                | e :: t -> file.tete <- t; file.queue <- []; e )
    | e :: t -> file.tete <- t; e;;

let tete file=
  match file.tete with
  | [] ->
      (match List.rev file.queue with
       | [] -> None
       | x :: _ -> Some x)
  | x :: _ -> Some x;;

let parcours_largeur g s0 = 
		let n = Array.length g in
		let decouverts = Array.make n false in
		let file = filevide () in 
		let parcours = ref [] in 
		enfiler s0 file;
		decouverts.(s0) <- true;
		while not (est_vide file) do 
			let s = defiler file in
			parcours := s :: !parcours; 
			let m = List.length g.(s) in
			let voisins = ref g.(s) in 
			for k = 0 to m - 1 do
				let v = List.hd !voisins in 
				if  not decouverts.(v) then (decouverts.(v) <- true; enfiler v file);
				voisins := List.tl !voisins;  
			done;
		done;
		List.rev !parcours;;

let parcours_largeur g s0 = 
	let n = Array.length g in
	let decouverts = Array.make n false in
	let file = filevide () in 
	let parcours = ref [] in 
	enfiler s0 file;
	decouverts.(s0) <- true;
	while not (est_vide file) do 
		let s = defiler file in
		parcours := s :: !parcours;
		let rec parcours_voisins voisins = 
			match voisins with 
			 | [] -> ()
			 | v :: t -> if not decouverts.(v) then (decouverts.(v) <- true; enfiler v file); 
			             parcours_voisins t in
		parcours_voisins g.(s)
	done;
	List.rev !parcours;;


let parcours_largeur g s0 =
	let rec explorer file decouverts =
	    match file with
            | [] -> []
            | v::t when List.mem v decouverts -> explorer t decouverts
            | v::t -> v::(explorer (t @ g.(v)) (v::decouverts))
	in explorer [s0] [] ;;

let parcours_largeur g s0 =
	let n = Array.length g in
	let decouverts = Array.make n false in		
	let rec explorer file =
			match file with
						| [] -> []
						| v::t when decouverts.(v) -> explorer t
						| v::t -> decouverts.(v) <- true; v::(explorer (t @ g.(v)))
	in explorer [s0];;
	

let parcours_profondeur g s0 =
	let n = Array.length g in
	let decouverts = Array.make n false; in
	let rec explorer parcours s =
		if decouverts.(s)  
		then parcours  
		else (let suivants = g.(s) in decouverts.(s) <- true; List.fold_left explorer (parcours @ [s]) suivants)
	in explorer [] s0;;

let g = [| [1;2] ; [0;3;4] ; [0;5;6] ; [1] ; [1] ; [2] ; [2] |] ;;
parcours_largeur g 0;;


