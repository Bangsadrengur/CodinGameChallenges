import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    loop

loop :: IO ()
loop = do
    input_line <- getLine
    let input = words input_line
    let spacex = read (input!!0) :: Int
    let spacey = read (input!!1) :: Int
    
    mountainHeights <- replicateM 8 $ do
        input_line <- getLine
        let mountainh = read input_line :: Int -- represents the height of one mountain, from 9 to 0. Mountain heights are provided from left to right.
        return mountainh
        
    -- hPutStrLn stderr "Debug messages..."
    
    -- either:  FIRE (ship is firing its phase cannons) or HOLD (ship is not firing).
    putStrLn $ decideAction spacex mountainHeights
    
    loop
    
decideAction :: Int -> [Int] -> String
decideAction position mountains
  | maximum mountains == mountains !! position = "FIRE"
  | otherwise = "HOLD"
