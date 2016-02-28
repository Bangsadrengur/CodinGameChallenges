(* Auto-generated code below aims at helping you parse *)
(* the standard input according to the problem statement. *)
(* --- *)
(* Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders. *)

(* lightx: the X position of the light of power *)
(* lighty: the Y position of the light of power *)
(* initialtx: Thor's starting X position *)
(* initialty: Thor's starting Y position *)

let xMovement dx = match (compare dx 0) with
    | 1  -> ("E", -1)
    | -1 -> ("W", 1)
    | _  -> ("", 0)
    ;;
    
let yMovement dy = match (compare dy 0) with
    | 1  -> ("S", -1)
    | -1 -> ("N", 1)
    | _  -> ("", 0)
    ;;
    
let rec loop dx dy = 
    (*let remainingturns = int_of_string (input_line stdin) in*)
    
    let (long, xOff) = xMovement dx in
    let (lat, yOff) = yMovement dy in
    
    print_endline (lat ^ long);
    
    loop (dx + xOff) (dy + yOff);
    ;;
    

let line = input_line stdin in
let lightx, lighty, initialtx, initialty = Scanf.sscanf line "%d %d %d %d" (fun lightx lighty initialtx initialty -> (lightx, lighty, initialtx, initialty)) in

loop (lightx - initialtx) (lighty - initialty);
