let g = [| [1;2] ; [0;3;4] ; [0;5;6] ; [1] ; [1] ; [2] ; [2] |] ;;

let bfs g v0 =
	let visited = Array.make (Array.length g) false in
	let rec explore queue = (* queue -> file en anglais FIFO *)
	    match queue with
            | [] -> []
            | v::t when visited.(v) -> explore t
            | v::t -> visited.(v) <- true; v::(explore (t @ g.(v)))
	in explore [v0] ;;
bfs g 0 ;;

let dfs g v0 =
	let visited = Array.make (Array.length g) false in
	let rec explore stack =
	    match stack with
            | [] -> []
            | v::t when visited.(v) -> explore t
            | v::t -> visited.(v) <- true; v::(explore (g.(v) @ t))
	in explore [v0] ;;

dfs g 0 ;;

let dijkstra g v0 =
    let n = Array.length g in
	let visited = Array.make n false
	    and distances = Array.make n max_int
	    and parents = Array.make n max_int
        in  parents.(0) <- 0;
            distances.(v0) <- 0;
	let rec insert_node pq s =
	    match pq with
	        | [] -> [s]
	        | h::t when distances.(s) >= distances.(h) -> h::(insert_node t s)
	        | h::t -> s::h::t in
	let rec insert_neighbours neighbours pq =
	    match neighbours with
	        | [] -> pq
	        | (h,_)::t -> insert_neighbours t (insert_node pq h) in
	let rec update_distances_parents neighbours s =
	    match neighbours with
            | [] -> ()
            | (i,dist)::t when not visited.(i) -> (distances.(i) <- min distances.(i) (distances.(s)+ dist));
                                parents.(i) <- s;
                                update_distances_parents t s;
            | (_,_)::t -> update_distances_parents t s;
    in
	let rec explore pq = match pq with
		| [] -> distances, parents
		| v::q when visited.(v) -> explore q
		| v::q ->   visited.(v) <- true;
		            update_distances_parents g.(v) v;
			        explore (insert_neighbours g.(v) q)
	in explore [v0];;

let g = [| [(1,7);(2,1)] ;
           [(0,7);(2,5);(3,4);(4,2);(5,1)] ;
           [(0,1);(1,5);(4,2);(5,7)];
           [(1,4);(4,5)];
           [(1,2);(2,2);(3,5);(5,3)];
           [(1,2);(2,7);(4,3)] |] ;;

let (d,p) = dijkstra g 0 ;;

let g = [| [(1,7);(2,1)] ; [(3,4); (5,1)] ; [(1,5);(4,2);(5,7)] ; [] ; [(1,2);(3,5)] ; [(4,3)] |] ;;
let (d,p) = dijkstra g 0;;



