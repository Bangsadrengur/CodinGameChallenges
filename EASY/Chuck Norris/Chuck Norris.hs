import System.IO
import Control.Monad
import Data.Char
import Numeric

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    message <- getLine
    
    let binaryWord = stringToBinaryAscii message
    
    let lexemes = norrisLex [] binaryWord
    let norrisEncoded = norrisParse lexemes []
    
    hPutStrLn stderr $ show message
    hPutStrLn stderr $ show $ map (\char -> ord char) message
    hPutStrLn stderr $ show binaryWord
    hPutStrLn stderr $ show norrisEncoded
    
    -- hPutStrLn stderr "Debug messages..."

    -- Write answer to stdout
    putStrLn norrisEncoded
    return ()
    
stringToBinaryAscii :: String -> String
stringToBinaryAscii string = 
    foldr (\binaryChar partialWord -> binaryChar ++ partialWord) "" $
    map charToBinaryAscii string
    
charToBinaryAscii :: Char -> String
charToBinaryAscii char = take (7 - length trimBinaryAscii) ['0', '0'..] ++ trimBinaryAscii
    where trimBinaryAscii = showIntAtBase 2 intToDigit (ord char) ""
    
norrisParse :: [(Int, Char)] -> String -> String
-- norrisParse tokens partiallyParsed
norrisParse [] partiallyParsed = tail partiallyParsed
norrisParse tokens partiallyParsed
    | snd (head tokens) == '0' =
        norrisParse (tail tokens) (" 00 " ++ take (fst $ head tokens) ['0', '0' ..] ++ partiallyParsed)
    | otherwise =
        norrisParse (tail tokens) (" 0 " ++ take (fst $ head tokens) ['0', '0' ..] ++ partiallyParsed)
    
norrisLex :: [(Int, Char)] -> String -> [(Int, Char)]
norrisLex groupedDigits binaryChar 
    | binaryChar == [] = groupedDigits
    | groupedDigits == [] || head binaryChar /= snd (head groupedDigits) =
        norrisLex ((1, head binaryChar) : groupedDigits) (tail binaryChar)
    | otherwise = norrisLex ((fst firstDigit + 1, snd firstDigit) : tail groupedDigits) (tail binaryChar)
    where firstDigit = head groupedDigits
