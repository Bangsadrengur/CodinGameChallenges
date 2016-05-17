/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var N = parseInt(readline());
var houses = [];
var cost = 0;
var xBoundary = [0, 0];

for (var i = 0; i < N; i++) {
    var inputs = readline().split(' ');
    var X = parseInt(inputs[0]);
    var Y = parseInt(inputs[1]);
    
    var house = {
        x: X,
        y: Y
    };
    
    houses.push(house);
    
    if(i === 0) {
        xBoundary[0] = X;
        xBoundary[1] = X;
    }
    if(xBoundary[0] > X) xBoundary[0] = X;
    if(xBoundary[1] < X) xBoundary[1] = X;
}

houses.sort(function(a, b) {
    return a.y - b.y;
});


var middleHouse = houses[Math.floor(houses.length / 2)];

printErr("middleHouse", middleHouse.x, middleHouse.y);
houses.forEach(function(house) {
    printErr("house", house.x, house.y);
    cost += Math.abs(house.y - middleHouse.y);
});

printErr("xBoundary", xBoundary[0], xBoundary[1]);
cost += xBoundary[1] - xBoundary[0];

// Write an action using print()
// To debug: printErr('Debug messages...');

if(houses.length < 2) cost = 0;

print(cost);
