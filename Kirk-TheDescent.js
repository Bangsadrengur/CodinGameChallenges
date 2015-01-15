/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/


// game loop
while (true) {
    var inputs = readline().split(' ');
    var SX = parseInt(inputs[0]);
    var SY = parseInt(inputs[1]);
    
    var action = 'HOLD';
    
    var max_height = 0;
    var highest_mountain = 0;
    
    for (var i = 0; i < 8; i++) {
        var MH = parseInt(readline()); // represents the height of one mountain, from 9 to 0. Mountain heights are provided from left to right.
        if(MH > max_height) {
            max_height = MH;
            highest_mountain = i;
        }
    }
    
    if(SX === highest_mountain) {
        action = 'FIRE';
    } else {
        action = 'HOLD';
    }

    // Write an action using print()
    // To debug: printErr('Debug messages...');

    print(action); // either:  FIRE (ship is firing its phase cannons) or HOLD (ship is not firing).
}
