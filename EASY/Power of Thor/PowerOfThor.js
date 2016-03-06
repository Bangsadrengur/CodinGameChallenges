/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var inputs = readline().split(' ');
var LX = parseInt(inputs[0]); // the X position of the light of power
var LY = parseInt(inputs[1]); // the Y position of the light of power
var TX = parseInt(inputs[2]); // Thor's starting X position
var TY = parseInt(inputs[3]); // Thor's starting Y position

var lat= ''; // N S direction
var long = ''; // E W direction

var x_d = LX - TX; // Cartesian coordinate sysetm with positive going right / E
var y_d = TY - LY; // Cartesian coordinate system with positive going up / N

var steps_to_slope = 0; // Steps untill Thor can move diagonally
    
if(x_d > 0) {
    long = 'E';
} else {
    long = 'W'
}

if(y_d > 0) {
    lat = 'N';
} else {
    lat = 'S';
}

steps_to_slope = Math.abs(Math.abs(x_d) - Math.abs(y_d));

// game loop
while (true) {
    var E = parseInt(readline()); // The level of Thor's remaining energy, representing the number of moves he can still make.
    
    var direction = '';
    
    if(steps_to_slope > 0) {
        steps_to_slope--;
        if(x_d*x_d > y_d*y_d) {
            direction = long;
        } else {
            direction = lat;
        }
    } else {
        direction = lat + long;
    }
    
    // Write an action using print()
    // To debug: printErr('Debug messages...');
    print(direction); // A single line providing the move to be made: N NE E SE S SW W or NW
}
