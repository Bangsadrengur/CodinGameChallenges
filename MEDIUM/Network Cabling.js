/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var N = parseInt(readline());
var houses = [];
var maxY = 0;
var minY = 0;
var maxX = 0;
var minX = 0;
for (var i = 0; i < N; i++) {
    var inputs = readline().split(' ');
    var X = parseInt(inputs[0]);
    var Y = parseInt(inputs[1]);
    
    var house = {
        x: X,
        y: Y
    };
    
    houses.push(house);
    
    if(Y > maxY) maxY = Y;
    if(Y < minY) minY = Y;
    
    if(X > maxX) maxX = X;
    if(X < minX) minX = X;
}

var averageY = (maxY + minY) / 2;
var houseYCount = [];

for (var i = minY; i <= maxY; i++) {
    houseYCount[i - minY] = 0;
}

houses.forEach(function(house) {
    houseYCount[house.y - minY]++;
});

var optimalValue = 0;

printErr("minY", minY);
houseYCount.forEach(function(value, index) {
    printErr("optimal calc round", index, "value/count", value);
    optimalValue += value * (index + minY);
});

optimalValue /= houseYCount.length;
printErr("optimalValue pre round", optimalValue);
optimalValue = Math.ceil(optimalValue);

printErr("averageY", averageY);
printErr("houseYCount", houseYCount);
houses.forEach(function(house) {
    printErr("house", house.x, house.y);
});
printErr("optimalValue", optimalValue)

var cost = maxX - minX;
printErr("deltaX", cost);

houses.forEach(function(house) {
    cost += Math.abs(house.y - optimalValue);
});

// Write an action using print()
// To debug: printErr('Debug messages...');

if(houses.length < 2) cost = 0;

print(cost);
