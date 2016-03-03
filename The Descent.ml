open List;;

let rec getM mountains count = match count > -1 with
    | true -> getM ((int_of_string (input_line stdin)) :: mountains) (pred count)
    | _ -> mountains
;;
    
let index list value =
    let rec index' list value i = match list with
        | [] -> -1
        | head :: _ when head = value -> i
        | head :: tail -> index' tail value (succ i)
    in index' list value 0
;;

(* game loop *)
while true do
    let mountains = getM [] 7 in
    let highestM = List.fold_left max 0 mountains in
    let target = index mountains highestM in
    
    (* Write an action using print_endline *)
    (* To debug: prerr_endline "Debug message"; *)
    
    print_endline (string_of_int (7 - target)); (* The number of the mountain to fire on. *)
    ();
done;
