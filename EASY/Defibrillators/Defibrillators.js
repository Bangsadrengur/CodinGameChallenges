var LON = readline();
var LAT = readline();
var N = parseInt(readline());

LON = Number(LON.replace(",", "."));
LAT = Number(LAT.replace(",", "."));

var defibs = [];
for (var i = 0; i < N; i++) {
    var DEFIB = readline();
    var defib = DEFIB.split(';');
    var defibObject = {
        lon: Number(defib[4].replace(",", ".")),
        lat: Number(defib[5].replace(",", ".")),
        name: defib[1]
    };
    defibs.push(defibObject);
}

function calcX (abc, lat) {
    return (abc - LON) * Math.cos((lat + LAT) / 2);
}

function calcY (lon, lat) {
    return lat - LAT;
}

function calcDist (x, y) {
    return Math.sqrt(x*x + y*y) * 6731;
}

var currMin = Number.MAX_VALUE;

defibs.forEach(function(curr) {
    var x = calcX(curr.lon, curr.lat);
    var y = calcY(curr.lon, curr.lat);
    curr.dist = calcDist(x, y);
    if(currMin > curr.dist) {
        currMin = curr.dist;
    }
});

defibs.forEach(function(curr) {
    if(currMin === curr.dist) {
        print(curr.name);
    }
});
