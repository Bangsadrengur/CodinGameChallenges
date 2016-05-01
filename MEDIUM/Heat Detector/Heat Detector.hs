-- TODO: Binary search jumps instead of increment by one
import System.IO
import Control.Monad

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let input = words input_line
    let w = read (input!!0) :: Int -- width of the building.
    let h = read (input!!1) :: Int -- height of the building.
    input_line <- getLine
    let n = read input_line :: Int -- maximum number of turns before game over.
    input_line <- getLine
    let input = words input_line
    let x0 = read (input!!0) :: Int
    let y0 = read (input!!1) :: Int
    loop x0 y0 0 w 0 h
    
shakyY :: String -> Int
shakyY dir
    | ud == "U" = -1
    | ud == "D" = 1
    | otherwise = 0
    where ud = filter (\letter -> letter == 'U' || letter == 'D') dir
    
shakyX :: String -> Int
shakyX dir
    | lr == "L" = -1
    | lr == "R" = 1
    | otherwise = 0
    where lr = filter (\letter -> letter == 'R' || letter == 'L') dir
    
binaryDir :: Int -> Int -> (Int, Int) -> Int
binaryDir direction position boundaries
    | direction == -1 = position - (div (position + 1 - (fst boundaries)) 2)
    | direction == 1 = position + (div ((snd boundaries) - position) 2)
    | otherwise = position
    
nextMove :: Int -> Int -> (Int, Int, Int, Int) -> String -> (Int, Int)
nextMove x y (minX, maxX, minY, maxY) dir =
    let xDir = shakyX dir in
    let yDir = shakyY dir in
    let nextX = binaryDir xDir x (minX, maxX) in
    let nextY = binaryDir yDir y (minY, maxY) in
    (nextX, nextY)
    
resolveBoundaries x y minX maxX minY maxY dir
    | dir == "U" = (minX, maxX, minY, min maxY y)
    | dir == "D" = (minX, maxX, max minY y, maxY)
    | dir == "L" = (minX, min maxX x, minY, maxY)
    | dir == "R" = (max minX x, maxX, minY, maxY)
    | otherwise = (minX, maxX, minY, maxY)
    
setBoundaries x y minX maxX minY maxY dir =
    let ud = filter (\letter -> letter == 'U' || letter == 'D') dir in
    let lr = filter (\letter -> letter == 'R' || letter == 'L') dir in
    let (minX', maxX', minY', maxY') = resolveBoundaries x y minX maxX minY maxY ud in
    resolveBoundaries x y minX' maxX' minY' maxY' lr

loop :: Int -> Int -> Int -> Int -> Int -> Int -> IO ()
loop x y minX maxX minY maxY = do
    input_line <- getLine
    let bombdir = input_line :: String -- the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)
    
    -- Set new boundaries
    let (minX', maxX', minY', maxY') = setBoundaries x y minX maxX minY maxY bombdir
    let boundaries = (minX', maxX', minY', maxY')
    
    hPutStrLn stderr bombdir
    let (nextX, nextY) = nextMove x y boundaries bombdir
    
    -- hPutStrLn stderr "Debug messages..."
    
    -- the location of the next window Batman should jump to.
    putStrLn $ show nextX ++ " " ++ show nextY
    
    loop nextX nextY minX' maxX' minY' maxY'
