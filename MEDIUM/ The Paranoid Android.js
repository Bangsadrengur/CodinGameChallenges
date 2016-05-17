 /**
 * auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var inputs = readline().split(' ');
var nbfloors = parseint(inputs[0]); // number of floors
var width = parseint(inputs[1]); // width of the area
var nbrounds = parseint(inputs[2]); // maximum number of rounds
var exitfloor = parseint(inputs[3]); // floor on which the exit is found
var exitpos = parseint(inputs[4]); // position of the exit on its floor
var nbtotalclones = parseint(inputs[5]); // number of generated clones
var nbadditionalelevators = parseint(inputs[6]); // ignore (always zero)
var nbelevators = parseint(inputs[7]); // number of elevators
var elevators = [];
for (var i = 0; i < nbfloors; i++) {
    elevators.push([]);
}
for (var i = 0; i < nbelevators; i++) {
    var inputs = readline().split(' ');
    var elevatorfloor = parseint(inputs[0]); // floor on which this elevator is found
    var elevatorpos = parseint(inputs[1]); // position of the elevator on its floor
    elevators[elevatorfloor].push(elevatorpos);
    elevatorfloor + 1 < nbfloors && elevators[elevatorfloor + 1].push(elevatorpos);
    elevatorfloor + 2 < nbfloors && elevators[elevatorfloor + 2].push(elevatorpos);
}

function getexitdirection(exitpos, clonepos) {
    if(exitpos > clonepos) {
        return "right";
    }
    
    return "left";
}

function getelevatordirection(elevators, clonepos, currdir) {
    var elevator = elevators[0];
    
    function adjustelevator(dir) {
        if(dir === "left") {
            return 1;
        }
        
        return 0;
    }
    
    if(elevator - adjustelevator(currdir) < clonepos) {
        return "left";
    }
    
    return "right";
}

function getdirection(exitpos, droidpos, currfloor, exitfloor, elevators, currdir) {
    printerr("currfloor", currfloor);
    printerr("elevators currfloor", elevators[currfloor]);
    if(currfloor === exitfloor || elevators.length === 0) {
        return getexitdirection(exitpos, droidpos);
    }
    
    var floor = currfloor;
    if(!elevators[currfloor] && elevators[currfloor + 1]) {
        floor = currfloor + 1;
    } else if(!elevators[currfloor] && elevators[currfloor + 2]) {
        floor = currfloor + 2;
    }
    return getelevatordirection(elevators[floor], droidpos, currdir);
}

function createoutput(exitpos, droidpos, currdirection, currfloor) {
    printerr(currdirection);
    printerr()
    if(getdirection(exitpos, droidpos, currfloor, exitfloor, elevators, currdirection) === currdirection || currdirection === "none") {
        return "wait";
    }
    
    return "block";
}

// game loop
while (true) {
    var inputs = readline().split(' ');
    var clonefloor = parseint(inputs[0]); // floor of the leading clone
    var clonepos = parseint(inputs[1]); // position of the leading clone on its floor
    var direction = inputs[2]; // direction of the leading clone: left or right

    // write an action using print()
    // to debug: printerr('debug messages...');

    print(createoutput(exitpos, clonepos, direction, clonefloor)); // action: wait or block
}
