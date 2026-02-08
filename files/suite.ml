let next terme = terme + 1

let u_imp_for u0 n =
  let terme = ref u0 in
  for rang = 1 to n do
    terme := next !terme
  done;
  !terme

let u_imp_while u0 n =
  let terme = ref u0 in
  let rang = ref 0 in
  while !rang < n do
    terme := next !terme;
    incr rang (* identique à rang := !rang + 1 *)
  done;
  !rang

let rec u u0 n = if n = 0 then u0 else u u0 (n - 1) + 1;;

for i = 0 to 10 do
  Printf.printf "test rang --> %d\n" i;
  assert (u 0 i = u_imp_for 0 i);
  assert (u 0 i = u_imp_while 0 i)
done
