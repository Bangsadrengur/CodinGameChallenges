let mySplit (myString: string) (delimiter: char)= 
    let rec mySplit' (myString: string) (strings: string list) = 
        match 
            try Some (String.index myString delimiter)
            with Not_found -> None
        with
            | Some i -> 
                let tail = String.sub myString (i + 1) ((String.length myString) - i - 1) in
                let head = String.sub myString 0 i in
                mySplit' tail (head :: strings)
            | None -> myString :: strings
    in mySplit' myString []
;;
        
let getDefibs defibCount = 
    let rec getDefibs' defibCount defibs = match defibCount > 0 with
        | true -> let defib =
            mySplit (input_line stdin) ';' in
            getDefibs' (pred defibCount) (defib :: defibs)
        | _ -> defibs
    in getDefibs' defibCount []
;;

let calcX lonA latA lonB latB = (lonA -. lonB) *. cos((latA +. latB) /. 2.0);;
let calcY latA latB = latB -. latA;;
let calcd x y = sqrt(x *. x +. y *. y) *. 6371.0;;
let calcDistance lonA latA (lonB, latB) = 
    let xCoord = calcX lonA latA lonB latB in
    let yCoord = calcY latA latB in
    calcd xCoord yCoord
;;

let getCoords defib = 
    let latSplit = mySplit (List.hd defib) ',' in
    let lat = float_of_string (String.concat "." (List.rev latSplit)) in
    let lonSplit = mySplit (List.hd (List.tl defib)) ',' in
    let lon = float_of_string (String.concat "." (List.rev lonSplit)) in
    (lon, lat)
;;

let lon = input_line stdin in
let lat = input_line stdin in
let (lon', lat') = getCoords [lat; lon] in
let n = int_of_string (input_line stdin) in
let defibs = getDefibs n in
let defibsCoord = List.map (fun defib -> getCoords defib) defibs in
let calcDistance' = calcDistance lon' lat' in
let distances = List.map calcDistance' defibsCoord in
let minDist = List.fold_left (fun a b -> 
    match (a > b) with 
        | true -> b 
        | _ -> a
) 9.0e+18 distances in
let closest = List.find (fun defib ->
    let coords = getCoords defib in
    let dist = calcDistance' coords in
    dist = minDist
) defibs in
print_endline (List.nth closest 4);
