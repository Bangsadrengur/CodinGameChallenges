/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var R = parseInt(readline());
var L = parseInt(readline());

var line = [R];

for (var i = 1; i < L; i++) {
    var newLine = [];
    while(line.length > 0) {
        if(line.length === 1) {
            newLine.push(1);
            newLine.push(line.shift());
            break;
        }
        
        var value = line.shift();
        var count = 1;
        while(line[0] === value) {
            line.shift();
            count++;
        }
        
        newLine.push(count);
        newLine.push(value);
    }
    line = newLine;
}

var output = line.join(' ');

print(output);
