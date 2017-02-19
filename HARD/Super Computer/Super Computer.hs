import System.IO
import Control.Monad (replicateM)
import Data.List (sort)

data Job = Job { start :: Int, duration :: Int, end :: Int } deriving (Show)
type Jobs = [Job]

instance Ord Job where
    compare c1 c2 = compare (start c1) (start c2)
    (<) c1 c2 = (start c1) < (start c2)
    (>) c1 c2 = (start c1) > (start c2)

instance Eq Job where
    (==) c1 c2 = (start c1) == (start c2)

getJobCount :: IO (Int)
getJobCount = do
    input_line <- getLine
    let n = read input_line :: Int
    return n

getJobs :: Int -> IO Jobs
getJobs n =
    replicateM n $ do
        input_line <- getLine
        let input = words input_line
        let j = read (input!!0) :: Int
        let d = read (input!!1) :: Int
        return Job { start = j, duration = d, end = j + d - 1 }

jobFits :: Job -> Job -> Bool
jobFits new job = start job > end new

addIfValid :: Job -> Jobs -> Jobs
addIfValid job jobs
    | null jobs = [job]
    | jobFits job (head jobs) = job : jobs
    | otherwise = jobs

buildJobList' :: Jobs -> Jobs -> Jobs
buildJobList' jobs accumulator
    | null jobs = accumulator
    | otherwise = buildJobList' (tail jobs) accumulator'
    where accumulator' = addIfValid (head jobs) accumulator

buildJobList :: Jobs -> Jobs
buildJobList jobs = buildJobList' jobs []

getMaxJobsLength :: Jobs -> Int
getMaxJobsLength jobs = 
    length . buildJobList . reverse . sort $ jobs

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    jobCount <- getJobCount
    jobs <- getJobs jobCount

    -- hPutStrLn stderr $ show $ jobs
    -- hPutStrLn stderr $ show $ buildJobList . reverse . sort $ jobs

    let maxLength = getMaxJobsLength jobs
    
    -- Write answer to stdout
    putStrLn $ show maxLength
    return ()
