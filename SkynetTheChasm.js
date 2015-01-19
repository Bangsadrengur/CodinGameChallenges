/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var R = parseInt(readline()); // the length of the road before the gap.
var G = parseInt(readline()); // the length of the gap.
var L = parseInt(readline()); // the length of the landing platform.

// game loop
while (true) {
    var S = parseInt(readline()); // the motorbike's speed.
    var X = parseInt(readline()); // the position on the road of the motorbike.
    
    var action = 'WAIT';
    
    printErr('R:', R);
    printErr('X:', X);
    printErr('G:', G);
    printErr('L:', L);
    
    if(R - X > S && S < G) action = 'SPEED';
    if(R < X || S >= L || S > G) action = 'SLOW';
    if(R - X + G <= S && R - X > 0) action = 'JUMP';
    
    
    
    // Write an action using print()
    // To debug: printErr('Debug messages...');

    print(action); // A single line containing one of 4 keywords: SPEED, SLOW, JUMP, WAIT.
}
