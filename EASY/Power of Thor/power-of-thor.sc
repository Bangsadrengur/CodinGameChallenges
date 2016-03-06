import math._
import scala.util._

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 * ---
 * Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
 **/
object Player extends App {
    // lightx: the X position of the light of power
    // lighty: the Y position of the light of power
    // initialtx: Thor's starting X position
    // initialty: Thor's starting Y position
    val Array(lightx, lighty, initialtx, initialty) = for(i <- readLine split " ") yield i.toInt

    val xd = lightx - initialtx;
    val yd = lighty - initialty;
    
    def solver (xd: Int, yd: Int) : Unit = {
        if(xd > 0 && yd > 0) {
            println("SE");
            solver(xd - 1, yd - 1);
        } else if(xd > 0 && yd < 0) {
            println("NE");
            solver(xd - 1, yd + 1);
        } else if(xd < 0 && yd > 0) {
            println("SW");
            solver(xd + 1, yd - 1);
        } else if(xd < 0 && yd < 0) {
            println("NW");
            solver(xd + 1, yd + 1);
        } else if(xd > 0) {
            println("E");
            solver(xd - 1, yd);
        } else if(xd < 0) {
            println("W");
            solver(xd + 1, yd);
        } else if(yd > 0) {
            println("S");
            solver(xd, yd - 1);
        } else if(yd < 0) {
            println("N");
            solver(xd, yd + 1);
        }
    }
    
    solver(xd, yd);
}
