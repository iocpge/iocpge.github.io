let rec even a =
        match a with
        | 0 -> true
        | x -> odd (x - 1)
   and  odd a =
        match a with
        | 0 -> false
        | x -> even (x - 1);;

even 42;;
odd 21;;
odd 44;;
odd 0;;
even 99;;