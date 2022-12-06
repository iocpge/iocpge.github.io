let rec is_palindrome str =
    let n = String.length str in
        match n with
            | 0 | 1 -> true
            | _ -> if str.[0] = str.[n-1] then is_palindrome (String.sub str 1 (n-2)) else false
    ;;

is_palindrome("non");;
is_palindrome("pas");;
is_palindrome("otto");;
is_palindrome("essayasse");;
is_palindrome("girafarig");;
is_palindrome("esope reste ici et se repose");;
is_palindrome("esoperesteicietserepose");;

let rec rec_fib_word n = match n with
        | 0 -> ""
        | 1 -> "a"
        | 2 -> "b"
        | _ -> rec_fib_word (n - 1) ^ rec_fib_word (n - 2);;

let ite_fib_word n =
    let u1 = ref "a" and u2 = ref "b" in
    match n with
        | 0 -> ""
        | 1 -> "a"
        | 2 -> "b"
        | _ ->  for _ = 3 to n do
                    let tmp = !u2 in
                    u2 := !u2 ^ !u1; u1:= tmp;
                 done; !u2;;

let term_rec_fib_word n =
    let rec aux u2 u1 k = if k < n
                          then aux (u2 ^ u1) u2 (k + 1)
                          else u2 ^ u1
    in   match n with
                    | 0 -> ""
                    | 1 -> "a"
                    | 2 -> "b"
                    | _ -> aux "b" "a" 3
    ;;

let memo_fib_word n =
    let memo = Hashtbl.create n in
    let rec aux k = match k with
                | 0 -> ""
                | 1 -> "a"
                | 2 -> "b"
                | _ -> if Hashtbl.mem memo k then Hashtbl.find memo k else ((aux (k - 1)) ^ (aux (k - 2)))
    in aux n;;



for i=0 to 9 do
    Printf.printf "rec_fib_word %i -> %s\n" i (rec_fib_word i);
    Printf.printf "term_rec_fib_word %i -> %s\n" i (term_rec_fib_word i);
    Printf.printf "ite_fib_word %i -> %s\n" i (ite_fib_word i);
    Printf.printf "memo_fib_word %i -> %s\n" i (memo_fib_word i);
    assert ((rec_fib_word i) = (ite_fib_word i));
    assert ((rec_fib_word i) = (term_rec_fib_word i));
    assert ((rec_fib_word i) = (memo_fib_word i));
done;;

for i=4 to 9 do
    let result = memo_fib_word i in
    Printf.printf "Fibonnacci word -> %s -> %b\n" result (is_palindrome(String.sub result 0 ((String.length result) - 2)));
    assert (is_palindrome(String.sub result 0 ((String.length result) - 2)));
done;;




