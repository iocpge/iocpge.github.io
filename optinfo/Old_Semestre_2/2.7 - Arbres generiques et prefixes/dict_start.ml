type label = { key: string; value: int;};;
type dict =   Empty
            | Node of label * dict * dict;;


let rec add d k v = Empty;;

let rec mem d k = Empty;;

let rec find d k = failwith "Key error";;

let rec height t= 0;;

let rec prefix t = [];;

let rec infix t = [];;

(*TESTS *)

let d = Empty;;
let d = add d "Emilie" 165;;
let d = add d "Elouan" 175;;
let d = add d "Sasha" 170;;
let d = add d "Corentin" 175;;
let d = add d "Ouassim" 170;;
let d = add d "Jacques" 175;;
let d = add d "Alex" 178;;
let d = add d "Pablo" 180;;
let d = add d "Aurélien" 167;;
let d = add d "Camille" 170;;
let d = add d "Flavie" 165;;
let d = add d "Lucille" 170;;
let d = add d "Ruben" 169;;
let d = add d "Gwénolé" 168;;
let d = add d "Gaël" 167;;
let d = add d "Hugo" 167;;

find d "Emilie";;
find d "Hugo";;
add d "Olivier" 169;;

prefix d;;
infix d;;


