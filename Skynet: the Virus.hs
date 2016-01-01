import System.IO
import Control.Monad
import Data.Maybe

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let input = words input_line
    let n = read (input!!0) :: Int -- the total number of nodes in the level, including the gateways
    let l = read (input!!1) :: Int -- the number of links
    let e = read (input!!2) :: Int -- the number of exit gateways
    
    links <- replicateM l $ do
        input_line <- getLine
        let input = words input_line
        let n1 = read (input!!0) :: Int -- N1 and N2 defines a link between these nodes
        let n2 = read (input!!1) :: Int
        return (n1, n2)
    
    exitGateways <- replicateM e $ do
        input_line <- getLine
        let ei = read input_line :: Int -- the index of a gateway node
        return (ei)
        
    loop links exitGateways

loop :: [(Int, Int)] -> [Int] -> IO ()
loop links exitGateways= do
    input_line <- getLine
    let si = read input_line :: Int -- The index of the node on which the Skynet agent is positioned this turn
    
    -- hPutStrLn stderr "Debug messages..."
    
    let cut = linkToSever links exitGateways si
    let (node1, node2) = sortTuple cut
    let output = show node1 ++ " " ++ show node2
    putStrLn output
    
    loop [c | c <- links, c /= cut, c /= (sortTuple cut)] exitGateways

linkToSever :: [(Int, Int)] -> [Int] -> Int -> (Int, Int)
linkToSever links gateways agent
    | length criticalNodes /= 0 = criticalNodes !! 0
    | otherwise = nodes !! 0
    where nodes = nodeNextToGateway links gateways
          criticalNodes = agentNextToGateway links agent gateways
          
agentNextToGateway :: [(Int, Int)] -> Int -> [Int] -> [(Int, Int)]
agentNextToGateway links agent gateways = 
    filter (\link -> snd link == agent && elem (fst link) gateways) links
  
nodeNextToGateway :: [(Int, Int)] -> [Int] -> [(Int, Int)]
nodeNextToGateway links gateways = filter (\link -> elem (fst link) gateways || elem (snd link) gateways) links

sortTuple :: (Int, Int) -> (Int, Int)
sortTuple (x, y) 
    | x > y = (y, x)
    | otherwise = (x, y)
