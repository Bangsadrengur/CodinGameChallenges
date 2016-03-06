open List;;

let getValues n = 
    let rec getValues' n values = match n > 0 with
        | true -> getValues' (pred n) ((int_of_string (input_line stdin)) :: values)
        | _ -> values
    in getValues' n []
;;

let getClosestDist values valuesShifted =
    List.fold_left2 (fun a b c-> min (abs (b - c)) a) 9999 values valuesShifted
;;

let n = int_of_string (input_line stdin) in
let values = sort compare (getValues n) in
let valuesShifted = (tl values) @ [0] in
let closestDist = getClosestDist values valuesShifted in
print_endline (string_of_int closestDist); 
