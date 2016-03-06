import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let road = read input_line :: Int -- the length of the road before the gap.
    input_line <- getLine
    let gap = read input_line :: Int -- the length of the gap.
    input_line <- getLine
    let platform = read input_line :: Int -- the length of the landing platform.
    loop gap road

loop :: Int -> Int -> IO ()
loop gap road = do
    input_line <- getLine
    let speed = read input_line :: Int -- the motorbike's speed.
    input_line <- getLine
    let coordx = read input_line :: Int -- the position on the road of the motorbike.
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- A single line containing one of 4 keywords: SPEED, SLOW, JUMP, WAIT.
    let action = decideAction speed gap road
    putStrLn action
    
    loop gap (road - (determineSpeed speed action))
    
decideAction:: Int -> Int -> Int -> String
decideAction speed gap roadToGap
  | roadToGap < 0 = "SLOW"
  | roadToGap < speed = "JUMP"
  | speed > gap + 1 = "SLOW"
  | speed < gap + 1 = "SPEED"
  | otherwise = "WAIT"
  
determineSpeed :: Int -> String -> Int
determineSpeed speed action
  | action == "SPEED" = speed + 1
  | action == "SLOW" = speed - 1 
  | otherwise = speed
