import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let input = words input_line
    let w = read (input!!0) :: Int -- number of columns.
    let h = read (input!!1) :: Int -- number of rows.
    
    map <- replicateM h $ do
        line <- getLine
        -- represents a line in the grid and contains W integers. Each integer represents one room of a given type.
        
        return $ map (read::String -> Int) (words line)
    input_line <- getLine
    let ex = read input_line :: Int -- the coordinate along the X axis of the exit (not useful for this first mission, but must be read).
    loop map ex

loop :: [[Int]] -> Int -> IO ()
loop map exit = do
    input_line <- getLine
    let input = words input_line
    let xi = read (input!!0) :: Int
    let yi = read (input!!1) :: Int
    let pos = input!!2
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- One line containing the X Y coordinates of the room in which you believe Indy will be on the next turn.
    let blockType = (map !! yi) !! xi
    hPutStrLn stderr $ show blockType
    let (nextX, nextY) = typeHandler blockType xi yi pos
    putStrLn $ show nextX ++ " " ++ show nextY
    
    loop map exit
    
typeHandler :: Int -> (Int -> Int -> String -> (Int, Int))
typeHandler blockType 
    | blockType == 1 = (\x y pos -> (x, y + 1))
    | blockType == 2 = handleType2
    | blockType == 3 = (\x y pos -> (x, y + 1))
    | blockType == 4 = handleType4
    | blockType == 5 = handleType5
    | blockType == 6 = handleType6
    | blockType == 7 = (\x y pos -> (x, y + 1))
    | blockType == 8 = (\x y pos -> (x, y + 1))
    | blockType == 9 = (\x y pos -> (x, y + 1))
    | blockType == 10 = (\x y pos -> (x - 1, y))
    | blockType == 11 = handleType11
    | blockType == 12 = (\x y pos -> (x, y + 1))
    | blockType == 13 = handleType13
    
handleType2 :: Int -> Int -> String -> (Int, Int)
handleType2 currX currY pos 
    | pos == "LEFT" = (currX + 1, currY)
    | otherwise = (currX - 1, currY)
    
handleType4 :: Int -> Int -> String -> (Int, Int)
handleType4 currX currY pos 
    | pos == "TOP" = (currX - 1, currY)
    | otherwise = (currX, currY + 1)
    
handleType5 :: Int -> Int -> String -> (Int, Int)
handleType5 currX currY pos 
    | pos == "TOP" = (currX + 1, currY)
    | otherwise = (currX, currY + 1)
    
handleType6 :: Int -> Int -> String -> (Int, Int)
handleType6 currX currY pos 
    | pos == "LEFT" = (currX + 1, currY)
    | otherwise = (currX - 1, currY)

handleType11 :: Int -> Int -> String -> (Int, Int)
handleType11 currX currY pos = (currX + 1, currY)

handleType13 :: Int -> Int -> String -> (Int, Int)
handleType13 currX currY pos = (currX, currY + 1)
