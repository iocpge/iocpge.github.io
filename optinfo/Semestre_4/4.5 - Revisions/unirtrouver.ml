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

let graph_to_w_edges g =
    let rec n_edges acc u lst =
      match lst with
       | [] -> acc
       | (v,w)::t -> if List.mem (v,u,w) acc
                     then n_edges acc u t
                     else n_edges ((u,v,w)::acc) u t in
    let rec edges u acc graph =
       match graph with
        | [] -> acc
        | lst :: t -> edges (u+1) (n_edges acc u lst) t
    in let e = edges 0 [] g in
    List.sort (fun (_,_,w1) (_,_,w2) -> compare w1 w2) e;;


let kruskal g =
  let edges = graph_to_w_edges g in
  let n = List.length g in
  let uf = uf_init n in
  let rec loop st_edges remaining_edges =
    match remaining_edges with
    | [] -> st_edges
    | (u,v,w) :: t ->
         let root_src = uf_find uf u in
         let root_dest = uf_find uf v in
         if root_src <> root_dest
         then
             begin
               uf_union uf root_src root_dest;
               loop ((u,v,w) :: st_edges) t
             end
         else loop st_edges t
  in
  loop [] edges;;




(* TESTS *)
let uf = { parent = [|0;1;2;3;4|];
           rank = [|0;0;0;0;0|] };;

let n = 5;;
let uf = uf_init n ;;
uf_find uf 3;;
uf_union uf 0 1;;
uf_union uf 2 3;;
uf_union uf 0 4;;
uf.parent;;
uf.rank;;

Printf.printf "Root of 1: %d\n" (uf_find uf 1);;
Printf.printf "Root of 3: %d\n" (uf_find uf 3);;
Printf.printf "Root of 4: %d\n" (uf_find uf 4);;


(* Example usage *)
let g = [[(1,2);(2,4)];[(0,2);(2,1);(3,5)];[(0,4);(1,1);(3,3)];[(1,5);(2,3)]];;
graph_to_w_edges g;;
let mst = kruskal g;;
Printf.printf "Minimum Spanning Tree Edges:\n";;
List.iter (fun (u,v,w) -> Printf.printf "Src: %d, Dest: %d, Weight: %d\n" u v w) mst;;

