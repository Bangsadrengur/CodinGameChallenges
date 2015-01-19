/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var R = parseInt(readline()); // the length of the road before the gap.
var G = parseInt(readline()); // the length of the gap.
var L = parseInt(readline()); // the length of the landing platform.

// Find maximum speed for jump assuming the motorbike lands so it can use the entire landing strip.
var v_l = 1;
var l_sum = 1;
while(l_sum <= L) {
    v_l = v_l + 1;
    l_sum += v_l;
}

// game loop
while (true) {
    var S = parseInt(readline()); // the motorbike's speed.
    var X = parseInt(readline()); // the position on the road of the motorbike.
    
    //var v_l = Math.floor(1/2 + Math.sqrt(1+2*L)/2);
    var v_g = G + 1;

    printErr('(R - X) / S', (R - X) / Math.max(S,1));
    printErr('v_l:', v_l);
    printErr('v_g:', v_g);
    
    var action = 'WAIT';
    
    printErr('R:', R);
    printErr('X:', X);
    printErr('G:', G);
    printErr('L:', L);
    
    if(S < v_g) action = 'SPEED';
    if(S > v_l || R < X) action = 'SLOW';
    if(S >= G + R - X && R > X) action = 'JUMP';
    if(R - X - 1 < S && action === 'WAIT') action = 'SLOW';
    
    // Write an action using print()
    // To debug: printErr('Debug messages...');

    print(action); // A single line containing one of 4 keywords: SPEED, SLOW, JUMP, WAIT.
}
