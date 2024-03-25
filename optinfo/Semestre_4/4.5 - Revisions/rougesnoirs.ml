type color = Rouge | Noir;;
type 'a abr = Vide | Noeud of color * 'a * 'a abr * 'a abr;;    

let a1 =
  Noeud(Noir,40,
    Noeud(Rouge,20,
      Noeud(Noir,10, Vide, Vide),
      Noeud(Noir,30, Vide, Vide)
    ),
    Noeud(Rouge,50,
      Noeud(Noir,60, Vide, Vide),
      Noeud(Noir,70, Vide, Vide)
    )
  );;

let a2 =
  Noeud(Noir,40,
    Noeud(Rouge,20,
      Noeud(Rouge,10, Vide, Vide),
      Noeud(Noir,30, Vide, Vide)
    ),
    Noeud(Rouge,50,
      Noeud(Noir,60, Vide, Vide),
      Noeud(Noir,70, Noeud(Noir,2, Vide, Noeud(Noir,5, Vide, Vide)), Vide)
    )
  );;

let rec hauteur t=
    match t with
        | Vide -> -1
        | Noeud(_, _,g,d) -> 1 + max (hauteur d)  (hauteur g);;

hauteur a1;;
hauteur a2;;

let rec taille t =
    match t with
        | Vide -> 0
        | Noeud (_,_,g,d) -> 1 + taille g + taille d;;

taille a1;;
taille a2;;

let rec mem e t =
    match t with
        | Vide -> false
        | Noeud (_, x, g, d) ->  e = x || (e < x && mem e g) || (e > x && mem e d);;

mem 42 a1;;
mem 7 a2;;
mem 70 a2;;


let rec est_equilibre t =
    match t with
        | Vide -> true
        | Noeud (_,_,g,d) -> est_equilibre g && est_equilibre d && abs (hauteur g - hauteur d) < 2;;

est_equilibre a1;;
est_equilibre a2;;

 let parcours_prefixe t =
     let rec aux a =
         match a with
            | Vide -> []
            | Noeud (_,e,g,d) -> e :: (aux g @ aux d) in
     aux t;;

 let parcours_prefixe t = (* version récursive terminale sans @ *)
     let rec aux acc a =
         match a with
            | Vide -> acc
            | Noeud (_,e,g,d) -> e :: (aux  (aux acc d) g) in
     aux [] t;;

parcours_prefixe a1;;
parcours_prefixe a2;;


let rec h_noir t =
    match t with
        | Vide -> 0
        | Noeud(Noir, _,l,_) -> 1 + h_noir l
        | Noeud(Rouge, _,l,_) -> h_noir l;;

let a3 =
  Noeud(Noir,40,
    Noeud(Rouge,20,
      Noeud(Noir,10, Noeud(Noir,5, Vide, Vide), Vide),
      Noeud(Noir,30, Vide, Noeud(Noir,35, Vide, Vide))
    ),
    Noeud(Rouge,50,
      Noeud(Noir,60, Noeud(Noir,55, Vide, Vide), Vide),
      Noeud(Noir,70, Noeud(Noir,65, Vide, Vide), Noeud(Noir,75, Vide, Vide))
    )
  );;

h_noir a1;;
h_noir a3;;


let rec check_local t =
    match t with
        | Vide -> true
        | Noeud(Rouge,_,Noeud(Rouge,_,_,_),_) | Noeud(Rouge,_,_,Noeud(Rouge,_,_,_)) -> false
        | Noeud(_,_,g,d) -> (check_local g) && (check_local d);;

check_local a1;;
check_local a2;;
check_local a3;;

let check_global t =
    let hb = h_noir t in
    let rec aux nb a =
        match a with
            | Vide -> nb = 0
            | Noeud(Noir,_,g,d) -> aux (nb - 1) g && aux (nb - 1) d
            | Noeud(Rouge,_,g,d) -> aux nb g && aux nb d in
    aux hb t;;

check_global a1;;
check_global a2;;
check_global a3;;


let est_rn t = check_global t && check_local t;;
est_rn a1;;
est_rn a2;;
est_rn a3;;


let rn_balance t =
    match t with
        | Vide -> Vide
        | Noeud(Noir, z, Noeud (Rouge, y, Noeud (Rouge, x, a, b), c), d)
        | Noeud(Noir, z, Noeud (Rouge, x, a, Noeud (Rouge, y, b, c)), d)
        | Noeud(Noir, x, a, Noeud (Rouge, z, Noeud (Rouge, y, b, c), d))
        | Noeud(Noir, x, a, Noeud (Rouge, y, b, Noeud (Rouge, z, c, d))) -> Noeud (Rouge, y, Noeud (Noir, x, a, b), Noeud (Noir, z, c, d))
        | Noeud(a, b, c, d) -> Noeud (a, b, c, d);;

rn_balance a1;;
rn_balance a2;;
rn_balance a3;;

let insert x t =
  let rec ins a =
    match a with
        | Vide -> Noeud (Rouge, x, Vide, Vide)
        | Noeud (c, e, g, d) as n ->
                if      x < e then rn_balance (Noeud(c, e, ins g, d))
                else if x > e then rn_balance (Noeud(c, e, g, ins d))
                else n
  in
  match ins t with
  | Noeud (_, e, g, d) -> Noeud (Noir, e, g, d)
  | Vide -> failwith "Vide ?? WTF !!!";;


let a =
insert 40
(insert 50
(insert 20
(insert 70 (insert 60 (insert 30 (insert 10 (insert 5 (insert 35 (insert 75 (insert 65 (insert 55 Vide)))))))))));;
a;;