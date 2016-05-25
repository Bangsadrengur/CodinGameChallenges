/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var n = parseInt(readline());
var inputs = readline().split(' ');
var vs = [];
for (var i = 0; i < n; i++) {
    var v = parseInt(inputs[i]);
    vs.push(v);
}

var max = vs[0];
var min = vs[0];
var d = 0;

vs.forEach(function(value, index, array) {
    if(value > max) {
        max = value;
        min = value;
    }
    
    if(value < min) {
        min = value;
    }
    
    if(d < max - min) {
        d = max - min;
    }
});

var p = -d;

// Write an action using print()
// To debug: printErr('Debug messages...');

print(p);
