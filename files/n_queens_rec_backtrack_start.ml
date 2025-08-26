let show_sol board =
    let print_row col = for c = 0 to (List.length board) - 1 do
                            if col = c then print_string "\u{2655} " else print_string ". "
                        done; print_newline() in
        let rec aux b = match b with
            | [] -> print_newline()
            | col::t -> print_row col; print_newline(); aux t;
        in print_newline(); aux board
  ;;

let under_attack row col board = 
    let rec loop b i = 
     match b with 
      | [] -> false
      | j::t -> if j = col || (i + j) = (row + col) || (i - j) = (row - col) then true else loop t (i + 1)
    in loop board 0;;

let synth solutions = 
  List.iter show_sol solutions;
  Printf.printf "Nombre de solutions #%d\n" (List.length solutions);;

let n_queens n =
  let rec build_solutions row current_board = 
    if row = n  (* On a trouvé une solution *)
      then [current_board] (* On la renvoie dans une liste *)
      else (* Trouver toutes les solutions possibles en construisant toutes les nouvelles lignes possibles *)
        let rec build_line_with c solutions =
          (* Si c = n : on a testé toutes les colonnes possibles  pour l'ajout d'une reine *)
          (* Alors on renvoie la liste des solutions possibles *)
          (* Sinon *)
               (* Si on peut mettre une reine en c *)
               (* Alors construire toutes les solutions possibles avec une reine en c et les ajouer à solutions *)
               (* Sinon essayer en c + 1 *)
      in build_line_with 0 []
   in build_solutions 0 [];;


synth (n_queens 4);;

(* synth (n_queens 5);;
synth (n_queens 6);;
synth (n_queens 7);;
synth (n_queens 8);; *)
(*synth (n_queens 12);;*)









