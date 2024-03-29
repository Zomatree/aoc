module Main where

import Data.List
import System.Environment
import qualified Data.Map as Map

import qualified Day1 (solve)
import qualified Day2 (solve)
import qualified Day3 (solve)
import qualified Day4 (solve)
import qualified Day5 (solve)
import qualified Day6 (solve)
import qualified Day7 (solve)
import qualified Day8 (solve)

import Data.Maybe (mapMaybe)

days = Map.fromList [("1", Day1.solve), ("2", Day2.solve), ("3", Day3.solve), ("4", Day4.solve), ("5", Day5.solve), ("6", Day6.solve), ("7", Day7.solve), ("8", Day8.solve)]

runDay :: String -> (String -> (String, String)) -> IO (String, String)
runDay day solve = do
    input_data <- readFile $ "data/" ++ "day" ++ day ++ ".txt"
    return $ solve input_data


main :: IO ()
main = do
    args <- getArgs
    let day = head args
    putStrLn $ "Running day " ++ day
    let solveMaybe = Map.lookup day days
    case solveMaybe of
        Just solve -> do
            result <- runDay day solve
            let (partA, partB) = result
            putStrLn $ "Part A:\n" ++ partA
            putStrLn $ "Part B:\n" ++ partB

        Nothing -> putStrLn "Invalid Day"
