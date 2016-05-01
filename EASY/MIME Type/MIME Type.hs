import System.IO
import Control.Monad
import Data.List
import System.FilePath.Posix
import Data.Map
import Data.Maybe
import Data.Char (toLower)

getExtension :: String -> String
getExtension filename = sanitizeExt $ takeExtension filename

sanitizeExt :: String -> String
sanitizeExt "" = "UNKNOWN"
sanitizeExt ext = tail ext

lookupMime :: Map String String -> String -> String
lookupMime _ "UNKNOWN" = "UNKNOWN"
lookupMime mimemap ext =
    sanitizeLookup $ Data.Map.lookup ext mimemap

sanitizeLookup :: Maybe String -> String
sanitizeLookup mime = fromMaybe "UNKNOWN" mime

mimeLookup :: Map String String -> String -> String
mimeLookup mimemap filename =
    lookupMime mimemap $ getExtension filename

mapFilesToMimes :: Map String String -> [String] -> [String]
mapFilesToMimes mimemap filenames =
    Data.List.map (mimeLookup mimemap) filenames

outputMimes outputs = mapM_ putStrLn outputs

getMimes :: Map String String -> IO (Map String String)
getMimes mimes = do 
    input_line <- getLine
    let input = words input_line
    let ext = input!!0 -- file extension
    let mt = input!!1 --  MIME type.
    let mimes' = Data.Map.insert (Data.List.map toLower ext) mt mimes
    return mimes'
    
populateMimes :: Map String String -> Int -> IO(Map String String)
populateMimes mimes count
    | count > 0 = do 
        mimes' <- getMimes mimes
        populateMimes mimes' (count - 1)
    | otherwise = do 
        return mimes

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    hPutStrLn stderr input_line
    let n = read input_line :: Int -- Number of elements which make up the association table.
    input_line <- getLine
    hPutStrLn stderr input_line
    let q = read input_line :: Int -- Number Q of file names to be analyzed.
    
    eAM <- populateMimes Data.Map.empty n
    
    fileNames <- replicateM q $ do
        fname <- getLine
        hPutStrLn stderr fname
        let input = words input_line
        -- One file name per line.
        return (Data.List.map toLower fname)
        
    let outputs = mapFilesToMimes eAM fileNames
    outputMimes outputs
        
    -- hPutStrLn stderr "Debug messages..."
    
    -- For each of the Q filenames, display on a line the corresponding MIME type. If there is no corresponding type, then display UNKNOWN.
    return ()
