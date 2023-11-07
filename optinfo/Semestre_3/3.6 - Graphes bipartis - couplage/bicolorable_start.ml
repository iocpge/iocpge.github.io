let bg = [| [3;4] ; [3;5;6] ; [4;6] ; [0;1] ; [0;2] ; [1] ; [1;2] |] ;;
let bg_mod = [| [2;3;4] ; [3;5;6] ; [4;6;0] ; [0;1] ; [0;2] ; [1] ; [1;2] |] ;;

type color_type = White | Black | Orange;;

let color_to_string color =  ();;

let next_color c = ();;

exception Not2colorable;;

let rec color_neighbours neighbours c = ();;

let bicolorable g v0 =
	let color = Array.make (Array.length g) White in
	let rec explore queue = ()
	    (* match queue with *)
	in try explore [(v0,Black)]; true with
	      | Not2colorable -> false;;

bicolorable bg 0 ;;
bicolorable bg_mod 0 ;;
