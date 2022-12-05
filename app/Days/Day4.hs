module Day4 where

import Data.List.Split
import Data.List (sort, intersect)

solve :: String -> (String, String)
solve input = (\x -> (solvePartA x, solvePartB x)) $ parseInput input

parseInput :: String -> [([Int], [Int])]
parseInput = map ((\x -> ([read $ head $ head x .. read $ last $ head x], [read $ head $ last x .. read $ last $ last x])) . map (splitOn "-") . splitOn ",") . lines

solvePartA :: [([Int], [Int])] -> String
solvePartA = show . length . filter (\(a, b) -> length (a `intersect` b) == length a || length (a `intersect` b) == length b)

solvePartB :: [([Int], [Int])] -> String
solvePartB = show . length . filter (\(a, b) -> not $ null (a `intersect` b))
