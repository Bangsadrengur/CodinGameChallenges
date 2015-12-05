import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Don't let the machines win. You are humanity's last hope...
    
    input_line <- getLine
    let width = read input_line :: Int -- the number of cells on the X axis
    input_line <- getLine
    let height = read input_line :: Int -- the number of cells on the Y axis
    
    lines <- replicateM height $ do
        -- width characters, each either 0 or .
        getLine
        
    hPutStrLn stderr $ show lines
    hPutStrLn stderr $ show height
    hPutStrLn stderr $ show width
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- Three coordinates: a node, its right neighbor, its bottom neighbor
    outputNodes (width - 1) (height - 1) width height lines
        
    return ()
    
coordRight :: Int -> Int -> Int -> [String] -> String
coordRight x y width lines
  | 0 <= x && x < width - 1 = 
    if lines !! y !! (x + 1) == '0'
    then
      show (x + 1) ++ " " ++ show y
    else
      coordRight (x + 1) y width lines
  | otherwise = "-1 -1"
    
coordBottom :: Int -> Int -> Int -> [String] -> String
coordBottom x y height lines
  | y < height - 1 =
    if lines !! (y + 1) !! x == '0'
    then
      show x ++ " " ++ show (y + 1)
    else
      coordBottom x (y + 1) height lines
  | otherwise = "-1 -1"
  
isValidNode :: Int -> Int -> [String] -> Bool
isValidNode x y lines = lines !! y !! x == '0'

outputNodes :: Int -> Int -> Int -> Int -> [String] -> IO ()
outputNodes x y width height lines
  | x < 0 = do 
    outputNodes (width - 1) (y - 1) width height lines
    return ()
  | x >= 0 && y >= 0 = do
    outputNodes (x - 1) y width height lines 
    if isValidNode x y lines
    then 
      putStrLn $ show x  ++ " " ++ show y ++ " " ++ (coordRight x y width lines) ++ " " ++ (coordBottom x y height lines)
    else
      return ()
  | otherwise = do
    return ()
