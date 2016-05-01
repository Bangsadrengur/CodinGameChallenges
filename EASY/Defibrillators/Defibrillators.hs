import System.IO
import Control.Monad
import Data.List.Split
import Data.List
import Data.Ord

replace old new = intercalate new . splitOn old

calcX :: Double -> Double -> Double -> Double -> Double
calcX lonA lonB latA latB = (lonB - lonA) * cos ((latA + latB) / 2)
calcY :: Double -> Double -> Double
calcY latA latB = latB - latA
calcDist :: Double -> Double -> Double
calcDist x y = sqrt ((x * x) + (y * y)) * 6371
doCalc :: Double -> Double -> Double -> Double -> Double
doCalc lonA latA lonB latB = calcDist (calcX lonA lonB latA latB) (calcY latA latB)
extractValues :: [String] -> (String, Double, Double)
extractValues (_:name:_:_:currLon:currLat:_) = 
    (
        name,
        read (replace "," "." currLon) :: Double,
        read (replace "," "." currLat) :: Double
    )

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    input_line <- getLine
    let lon = read (replace "," "." input_line) :: Double
    input_line <- getLine
    let lat = read (replace "," "." input_line) :: Double
    input_line <- getLine
    let n = read input_line :: Int
    
    defibs <- replicateM n $ do
        defib <- getLine
        return $ splitOn ";" defib
        
    let values = map extractValues defibs
    let doCalc' = doCalc lon lat
    let values' = map (\(name, lon, lat) -> (name, lon, lat, doCalc' lon lat)) values
    let sortedValues = sortBy (comparing (\(_,_,_,fourth) -> fourth)) values'
    let minValue = sortedValues !! 0
    putStrLn $ (\(name,_,_,_) -> name) minValue
    return ()
