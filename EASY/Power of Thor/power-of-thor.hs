import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    -- ---
    -- Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
    
    input_line <- getLine
    let input = words input_line
    let lightx = read (input!!0) :: Int -- the X position of the light of power
    let lighty = read (input!!1) :: Int -- the Y position of the light of power
    let initialtx = read (input!!2) :: Int -- Thor's starting X position
    let initialty = read (input!!3) :: Int -- Thor's starting Y position
    loop initialtx initialty lightx lighty

loop :: Int -> Int -> Int -> Int -> IO ()
loop currentx currenty lightx lighty= do
    input_line <- getLine
    let remainingturns = read input_line :: Int -- The remaining amount of turns Thor can move. Do not remove this line.
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- A single line providing the move to be made: N NE E SE S SW W or NW
    let target = guideToLight currentx currenty lightx lighty
    putStrLn target
    
    let (nextx, nexty) = relocateThor currentx currenty target
    loop nextx nexty lightx lighty
    
guideToLight :: Int -> Int -> Int -> Int -> String
guideToLight currentx currenty lightx lighty 
  -- East directions
  | currentx < lightx && currenty == lighty = "E"
  | currentx < lightx && currenty < lighty = "SE"
  | currentx < lightx && currenty > lighty = "NE"
  -- West directions
  | currentx > lightx && currenty == lighty = "W"
  | currentx > lightx && currenty < lighty = "SW"
  | currentx > lightx && currenty > lighty = "NW"
  -- Rest
  | currentx == lightx && currenty < lighty = "S"
  | currentx == lightx && currenty > lighty = "N"
  
relocateThor :: Int -> Int -> String -> (Int, Int)
relocateThor currentx currenty direction 
  -- East directions
  | direction == "E" = (currentx - 1, currenty)
  | direction == "SE" = (currentx - 1, currenty + 1)
  | direction == "NE" = (currentx - 1, currenty - 1)
  -- West directions
  | direction == "W" = (currentx + 1, currenty)
  | direction == "SW" = (currentx + 1, currenty + 1)
  | direction == "NW" = (currentx + 1, currenty - 1)
  -- Rest
  | direction == "S" = (currentx, currenty + 1)
  | direction == "N" = (currentx, currenty - 1)
