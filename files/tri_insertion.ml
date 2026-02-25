let insertion_sort t =
  for i = 1 to Array.length t - 1 do
    let elem = t.(i) in
    let j = ref i in
    while !j > 0 && t.(!j - 1) > elem do
      t.(!j) <- t.(!j - 1);
      decr j
    done;
    t.(!j) <- elem
  done
;;

let tab = [| 4; -4; 22; 0; 1; 9; -10; 3 |] in
insertion_sort tab;
tab
