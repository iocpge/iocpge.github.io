
type list_graph = (int * int) list list;;

let lcg = [ [(2,1); (1,7)];
            [(3,4); (4,2); (2,5); (0,7)];
            [(5,7); (4,2); (1,5); (0,1)];
            [(4,5); (1,4)];
            [(5,3); (3,5); (2,2); (1,2)];
            [(4,3); (2,7)]];;

let uclg = [ [(1,7)];
             [(4,1); (3,4); (0,7)];
             [(5,7)];
             [(4,5); (1,4)];
             [(3,5); (1,2)];
             [(2,7)]];;

let make_triplets_list lg =
    let filter triplets edges = triplets@List.filter_map (fun (i,j,w) ->
                if not (List.mem (i,j,w) triplets) && not (List.mem (j,i,w) triplets)
                then Some (i,j,w)
                else None
                ) edges in
    List.fold_left filter [] (List.mapi (fun i edges ->  List.map (fun (j,w) -> (i,j,w) ) edges) lg);;

make_triplets_list lcg;;
make_triplets_list uclg;;