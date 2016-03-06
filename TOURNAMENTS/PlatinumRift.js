/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

var inputs = readline().split(' ');
var playerCount = parseInt(inputs[0]); // the amount of players (2 to 4)
var myId = parseInt(inputs[1]); // my player ID (0, 1, 2 or 3)
var zoneCount = parseInt(inputs[2]); // the amount of zones on the map
var linkCount = parseInt(inputs[3]); // the amount of links between all zones

// Array of [zoneId, platinum amount]
var zoneIdPlatinum = [];
for (var i = 0; i < zoneCount; i++) {
    var inputs = readline().split(' ');
    var zoneId = parseInt(inputs[0]); // this zone's ID (between 0 and zoneCount-1)
    var platinumSource = parseInt(inputs[1]); // the amount of Platinum this zone can provide per game turn
    
    // Populate list of zonesId's and platinum amount
    zoneIdPlatinum.push(platinumSource);
}

// zone link list
var zoneLinks = [];
// List of possesion of zones
var currentOwnerOf= [];
// Initialize zone arrays
for (var i = 0; i != zoneCount; i++) {
    zoneLinks.push([]);
    currentOwnerOf.push(-1);
}

for (var i = 0; i < linkCount; i++) {
    var inputs = readline().split(' ');
    var zone1 = parseInt(inputs[0]);
    var zone2 = parseInt(inputs[1]);
    
    zoneLinks[zone1].push(zone2);
    zoneLinks[zone2].push(zone1);
}

var nextZonesFrom = function (zoneId, currentOwnerOf, numPodsP) {
    var destZones = [];
    var skipZones = [];
    var numMyPods = numPodsP[zoneId][myId];
    
    for (var i = 0; i < numMyPods; i++) {
        var destZone = nextZoneFrom(zoneId, currentOwnerOf, numPodsP, skipZones);
        if (destZone < 0) { 
            // No available enemy
            break; 
        }
        var numDestZoneEnemies = numPodsP[destZone].reduce(function (a,b) {return a + b;}); - numPodsP[destZone][myId];
        var unitsToDeploy = numDestZoneEnemies + 1;
        destZones.push([destZone, unitsToDeploy]);
        numPodsP[zoneId][myId] -= unitsToDeploy ;
        if (numPodsP[zoneId][myId] < 1) { 
            break; 
        }
        skipZones.push(destZone);
    }
    return destZones;
};

var nextZoneFrom = function (zoneId, currentOwnerOf, numPodsP, skipZones) {
    var bfsResult = BFS(zoneId, currentOwnerOf, numPodsP, skipZones);
    var destZone = bfsResult[0];
    var nextHop = bfsResult[1];
    
    if(destZone < 0) {
        return -2;
    }
    return nextHop;
};

var BFS = function (zoneId, currentOwnerOf, numPodsP, skipZones) {
    var nextHop = new Array(zoneCount);
    var queue = [];
    var zoneSet = new Array(zoneCount);
    var maxDepth = 60;
    var depthCounter = 0;
    var myNumPodsPropogate = new Array(zoneCount);
    
    skipZones.forEach(function (skipZone) {
        zoneSet[skipZone] = true;
    });
    
    zoneSet[zoneId] = true;
    zoneLinks[zoneId].forEach (function (zone) {
        if(!zoneSet[zone]) {
            zoneSet[zone] = true;
            queue.push(zone);
            nextHop[zone] = zone;
            myNumPodsPropogate[zone] = numPodsP[zoneId][myId];
        }
    });
    
    while(queue.length > 0) {
        var t = queue.shift();
        var numPodsOthers = numPodsP[t].reduce(function (a,b) {return a + b;});
        numPodsOthers -= numPodsP[t][myId];
        if(
            // There is a friendly route to zone
            currentOwnerOf[zoneId] === myId &&
            // Zone is not mine
            currentOwnerOf[t] !== myId && 
            // I have more bots
            myNumPodsPropogate[t] > numPodsOthers
            ) {
            return [t, nextHop[t]];
        }
        if(maxDepth === depthCounter++) {
            return [-2, nextHop[t]];
        }
        zoneLinks[t].forEach(function(zone) {
           if(!zoneSet[zone]) {
               zoneSet[zone] = true;
               queue.push(zone);
               nextHop[zone] = nextHop[t];
               myNumPodsPropogate[zone] = myNumPodsPropogate[t];
           }
        });
    }
    return [-2, []];
};

// Priority queue to optimze buy zone selection
function PriorityBuyQueue(maxLength) {
    this.maxLength = maxLength;
    this.elements = [];
    
    this.push = function(value) {
        if (this.maxLength === 0) return;
        if (this.maxLength > this.elements.length) {
            this.elements.push(value);
            this.elements.sort(function (a,b) {return b[1] - a[1];});
            return;
        }
        if (this.elements[this.elements.length - 1][1] < value[1]) {
            this.elements.pop();
            this.elements.push(value);
            this.elements.sort(function (a,b) {return b[1] - a[1];});
        }
    }
    
    this.pop = function () {
        return this.elements.pop();
    }
}

// game loop
while (true) {
    var platinum = parseInt(readline()); // my available Platinum
    
    var moveList = '';
    var buyList = '';
    var podsPArray = new Array(zoneCount);
    
    // Units available for the current platinum amount
    var unitsAvail = Math.floor(platinum/20);
    var unitsPerZone = 2;
    
    // Initialize new priority queue for buy selection
    var prioBuyQueue = new PriorityBuyQueue(Math.ceil(unitsAvail/unitsPerZone));
    
    for (var i = 0; i < zoneCount; i++) {
        var podsP = new Array(4);
        var inputs = readline().split(' ');
        var zId = parseInt(inputs[0]); // this zone's ID
        var ownerId = parseInt(inputs[1]); // the player who owns this zone (-1 otherwise)
        podsP[0] = parseInt(inputs[2]); // player 0's PODs on this zone
        podsP[1] = parseInt(inputs[3]); // player 1's PODs on this zone
        podsP[2] = parseInt(inputs[4]); // player 2's PODs on this zone (always 0 for a two player game)
        podsP[3] = parseInt(inputs[5]); // player 3's PODs on this zone (always 0 for a two or three player game)
        
        podsPArray[zId] = podsP;
        
        // Populate buy list
        if(ownerId === -1) {
            var random = Math.random();
            //if (random < 0.03) {
            if (random < 0.00) {
                prioBuyQueue.push([zId, 100]);
            } else {
                prioBuyQueue.push([zId, zoneIdPlatinum[zId]]);
            }
        }
        
        // Refresh array of current zone owner
        currentOwnerOf[zId] = ownerId;
    }
        
    for(var i = 0; i < zoneCount; i++) {
        var zId = i;
        var ownerId = currentOwnerOf[zId];
        // Populate buy list with zones Adjacent to a lost zone
        var adjacentZones = zoneLinks[zId];
        
        var myPodsNum = podsPArray[zId][myId];
        
        if(ownerId !== myId) {
            for(var j = 0; j < adjacentZones.length; j++) {
                var adjId = adjacentZones[j];
                var ownerAdj = currentOwnerOf[adjId];
                if(ownerAdj === myId) {
                    prioBuyQueue.push([adjId, zoneIdPlatinum[zId]]);
                }
            }
        } 
        
        if(myPodsNum > 0) { 
            //var nextZone = nextZoneFrom(zId, currentOwnerOf, podsPArray, []);
            //if (nextZone >= 0) {
            //    moveList += myPodsNum + ' ' + zId + ' ' + nextZone + ' ';
            //}
            //printErr("PodsPArray: " + podsPArray[zId] + ' ');
            var nextZones = nextZonesFrom(zId, currentOwnerOf, podsPArray);
            var zoneAndUnit= nextZones.pop();
            while(zoneAndUnit) {
                var nextZone = zoneAndUnit[0];
                var unitsToDeploy = zoneAndUnit[1];
                moveList += unitsToDeploy + ' ' + zId + ' ' + nextZone + ' ';
                zoneAndUnit = nextZones.pop();
            }
        }
    }
        
    var zIdValue = prioBuyQueue.pop();
    if (zIdValue && (unitsAvail % unitsPerZone) > 0) {
        buyList += (unitsAvail % unitsPerZone) + ' ' + zIdValue[0] + ' ';
        zIdValue = prioBuyQueue.pop();
    }
    while (zIdValue) {
        buyList += unitsPerZone + ' ' + zIdValue[0] + ' ';
        zIdValue = prioBuyQueue.pop();
    }
    
    //printErr(moveList, " :: ");
    if(moveList !== "") {
        print(moveList);
    } else {
        print("WAIT");
    }
    //printErr(buyList);
    print(buyList);
}
