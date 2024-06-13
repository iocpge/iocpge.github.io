(* Stack implementation *)

type 'a stack = EmptyStack | Node of 'a * 'a stack

let empty () = EmptyStack;;

let is_empty s =
  match s with
  | EmptyStack -> true
  | Node (_, _) -> false;;

let push x s = Node (x, s)

let pop s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, s') -> (x, s');;

let peek s =
  match s with
  | EmptyStack -> failwith "Empty Stack"
  | Node (x, _) -> x;;

let p = push 3 (push 4 (push 5 EmptyStack));;
let sommet = peek p;;
let s, st = pop p;;
p;;
is_empty p;;

push 4 (push 3 EmptyStack);;