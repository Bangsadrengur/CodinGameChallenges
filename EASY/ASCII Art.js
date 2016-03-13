/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var L = parseInt(readline());
var H = parseInt(readline());
var T = readline();
var alphabet = [];
for (var i = 0; i < H; i++) {
    var ROW = readline();
    alphabet.push(ROW);
}

var letters = {};

for(var i = 0; i != 28; i++) {
    var chrCode = i + 65;
    var letter = String.fromCharCode(chrCode);
    letters[letter] = [];
    alphabet.forEach(function(curr) {
        var line = curr.slice(i * L, i * L + L);
        letters[letter].push(line);
    });
}

var t = T.toUpperCase();
var word = t.split("");
var wordBlock = [];
for(var i = 0; i != H; i++) {
    wordBlock.push([]);
}

word.forEach(function(letter) {
    var charCode = letter.charCodeAt(0) - 65;
    if(charCode < 0 || charCode > 25) {
        letter = String.fromCharCode(26 + 65);
    }
    letters[letter].forEach(function(curr, index) {
        wordBlock[index].push(curr);
    });
});

wordBlock.forEach(function(curr, index) {
    var line = curr.join();
    line = line.replace(/,/g, "");
    print(line);
});


// Write an action using print()
// To debug: printErr('Debug messages...');
