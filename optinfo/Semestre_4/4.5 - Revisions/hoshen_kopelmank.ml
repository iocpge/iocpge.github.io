type union_find = { parent : int array; rank : int array }

let uf_init n =
  let parent = Array.init n (fun i -> i) in
  let rank = Array.make n 0 in
  {parent = parent; rank = rank};;

let rec uf_find uf x =
  if uf.parent.(x) <> x then
     begin
       uf.parent.(x) <- uf_find uf uf.parent.(x);  (* Path compression *)
       uf.parent.(x)
     end
  else x;;

let uf_union uf x y =
  let root_x = uf_find uf x in
  let root_y = uf_find uf y in
  if root_x <> root_y then begin
    if uf.rank.(root_x) < uf.rank.(root_y) then
      uf.parent.(root_x) <- root_y
    else if uf.rank.(root_x) > uf.rank.(root_y) then
      uf.parent.(root_y) <- root_x
    else
      begin
       uf.parent.(root_x) <- root_y;
       uf.rank.(root_y) <- uf.rank.(root_y) + 1
      end
  end;;





let g = [|
    [| 1; 0; 1; 0 ; 0|];
    [| 1; 1; 0; 0 ; 1|];
    [| 0; 1; 0; 1 ; 1|];
    [| 0; 0; 1; 1 ; 0|];
  |];;  (* la grille de cellules *)
  
let occupied grid i j = grid.(i).(j) = 1;;

assert (occupied g 2 1);; 
assert (not (occupied g 1 2));;

let in_grid grid i j =
    let rows = Array.length grid in
    let cols = Array.length grid.(0) in
    i >= 0 && i < rows && j >= 0 && j < cols;;

assert (in_grid g 0 3);;
assert (not (in_grid g 43 0));;

let get_neighbours grid i j =
    let rec aux lst =
    match lst with
        | [] -> []
        | (ni,nj) :: t -> if in_grid grid ni nj then (ni,nj) :: (aux t) else aux t
    in let pn = [(i-1,j);(i+1,j);(i,j-1);(i,j+1)] in aux pn;;

get_neighbours g 1 0;;
get_neighbours g 3 3;;
get_neighbours g 2 3;;
get_neighbours g 0 3;;

let get_index ncols i j = i * ncols + j;;

assert (get_index 3 0 2  = 2);;
assert (get_index 4 3 3  = 15);;
assert (get_index 4 2 0  = 8);;


let get_neighbours_parts grid uf neighbours =
    let cols = Array.length grid.(0) in
    let rec map lst =
        match lst with
        | [] -> []
        | (i,j) :: t -> if occupied grid i j
                        then uf_find uf (get_index cols i j) :: (map t)
                        else map t
    in map neighbours;;

let rec clustering uf part neighbours_labels =
 match neighbours_labels with
    | [] -> ()   (* tout seul *)
    | h :: t -> uf_union uf h part; clustering uf part t;;

let hoshen_kopelman grid =
  let n_rows = Array.length grid in
  let n_cols = Array.length grid.(0) in
  let uf = uf_init (n_rows * n_cols) in
  let process_cell i j =
      if occupied grid i j
      then
         let neighbours = get_neighbours grid i j in
         let neighbours_parts = get_neighbours_parts grid uf neighbours in
         let part = uf_find uf (get_index n_cols i j) in
         clustering uf part neighbours_parts in
  for i = 0 to n_rows - 1 do
    for j = 0 to n_cols - 1 do
      process_cell i j
    done
  done;
  let part_map = Hashtbl.create 10 in
  let next_index = ref 1 in
  for i = 0 to n_rows - 1 do
    for j = 0 to n_cols - 1 do
      if grid.(i).(j) != 0
      then
       begin
        let index = (get_index n_cols i j) in
        let part = uf_find uf index in
        if not (Hashtbl.mem part_map part)
          then
            begin
               Hashtbl.add part_map part !next_index;
               next_index := !next_index + 1;
            end;
        grid.(i).(j) <- Hashtbl.find part_map part;
       end
    done
  done;;

(* TESTS *)
hoshen_kopelman g;;
g;;
assert (g = [|[|1; 0; 2; 0; 0|]; [|1; 1; 0; 0; 3|]; [|0; 1; 0; 3; 3|]; [|0; 0; 3; 3; 0|]|])

let g2 = [|
    [| 1; 0; 0; 1; 0 ; 1|];
    [| 0; 1; 1; 0; 1 ; 1|];
    [| 1; 0; 0; 1; 1 ; 1|];
    [| 0; 1; 0; 0; 1 ; 1|];
    [| 0; 1; 1; 0; 1 ; 1|];
    [| 1; 0; 1; 0; 1 ; 1|];
  |];;
hoshen_kopelman g2;;
g2;;