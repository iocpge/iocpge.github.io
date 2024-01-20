type 'a cell = { value : 'a ;
                 mutable before : 'a lst ;
                 mutable after : 'a lst}
      and 'a lst = Nil | Cell of 'a cell ;;

type 'a dequeue = { mutable head : 'a lst ;
                    mutable queue : 'a lst} ;;

let create_queue () = ();;(* TODO *)

let enqueue e q = 
    let c = Cell {value = e; before = q.queue; after = Nil} in
    ();;(* TODO *)
        
        
let dequeue q = () ;;(* TODO *)


(* TEST *)

let q = create_queue ();;
enqueue 3 q;;
q;;
enqueue 5 q;;
enqueue (-9) q;;
q;;

dequeue q;;
q;;
dequeue q;;
q;;
dequeue q;;
q;;
dequeue q;;
q;;

