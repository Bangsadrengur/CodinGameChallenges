#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <stdlib.h>

using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 * ---
 * Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
 **/
 
 // dy := y of Thor - y of light
string determineNS(int dy)
{
    if (dy == 0) return "";
    if (dy > 0) return "N";
    return "S";
}

// dx := x of Thor - x of light
string determineWE(int dx)
{
    if (dx == 0) return "";
    if (dx > 0) return "W";
    return "E";
}

struct intermediary {
    string WE;
    string NS;
    int thorX;
    int thorY;
};

intermediary determineOutput(int thorX, int thorY, int lightX, int lightY)
{
    int dx = thorX - lightX;
    int dy = thorY - lightY;
    string WE = determineWE(dx);
    string NS = determineNS(dy);
    
    int absDx = abs(dx);
    int absDy = abs(dy);
    if(absDx == 0) {
        absDx = 1;
    }
    if(absDy == 0) {
        absDy = 1;
    }
    int normalDx = dx / absDx;
    int normalDy = dy / absDy;
    
    int revisedThorX = thorX - normalDx;
    int revisedThorY = thorY - normalDy;
    
    static intermediary output;
    output.WE = WE;
    output.NS = NS;
    output.thorX = revisedThorX;
    output.thorY = revisedThorY;
    
    return output;
}
 
int main()
{
    int lightX; // the X position of the light of power
    int lightY; // the Y position of the light of power
    int initialTX; // Thor's starting X position
    int initialTY; // Thor's starting Y position
    cin >> lightX >> lightY >> initialTX >> initialTY; cin.ignore();
    
    intermediary lastRun = determineOutput(initialTX, initialTY, lightX, lightY);
    cout << lastRun.NS + lastRun.WE << endl;

    // game loop
    while (1) {
        int remainingTurns; // The remaining amount of turns Thor can move. Do not remove this line.
        cin >> remainingTurns; cin.ignore();
        
        
        lastRun = determineOutput(lastRun.thorX, lastRun.thorY, lightX, lightY);
        cout << lastRun.NS + lastRun.WE << endl;

        // Write an action using cout. DON'T FORGET THE "<< endl"
        // To debug: cerr << "Debug messages..." << endl;

        // A single line providing the move to be made: N NE E SE S SW W or NW
    }
}
