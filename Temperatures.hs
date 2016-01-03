import System.IO
import Control.Monad
import Data.Function
import Data.List
import Data.Monoid

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let n = read input_line :: Int -- the number of temperatures to analyse
    temps <- getLine
    -- the n temperatures expressed as integers ranging from -273 to 5526
    
    let tempsArray = map (read :: String -> Int) (words temps)
    let indexedTemps  = map (\x -> (abs x, x)) tempsArray
    let compareTuple = mconcat [compare `on` fst, flip $ on compare snd] 
    let sortedTemps = sortBy compareTuple indexedTemps
    
    -- hPutStrLn stderr "Debug messages..."
    hPutStrLn stderr $ show sortedTemps
    
    -- Write answer to stdout
    putStrLn $ show $ getTempClosestToZero sortedTemps
    return ()
    
getTempClosestToZero :: [(Int, Int)] -> Int
getTempClosestToZero sortedTemps
    | length sortedTemps == 0 = 0
    | otherwise = snd $ sortedTemps !! 0
