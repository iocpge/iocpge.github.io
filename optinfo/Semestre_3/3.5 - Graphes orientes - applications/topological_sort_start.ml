type vertex_state = To_Explore | Exploring | Explored;;



let g = [| [3] ; [3;4] ; [4;7] ; [5;6;7] ; [6] ; [] ; [] ; [] |] ;;
let gc = [| [3] ; [3;4] ; [4;7] ; [5;6;7] ; [6] ; [] ; [0] ; [] |] ;;
let big = [| [3] ; [3;4] ; [3;4] ; [6] ; [3;7;9] ; [6] ; [8;9;10] ; [9] ; [10;11]; [11]; [] ;[]|] ;;

let result = topological_sort g;;
