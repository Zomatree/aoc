module Day6 where

import Data.List

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

solvePartA :: String -> String
solvePartA i = show $ fst $ head $ filter (\(i, vs) -> length (nub vs) == length vs) (zip [4..] (transpose (take 4 (tails i))))

solvePartB :: String -> String
solvePartB i = show $ fst $ head $ filter (\(i, vs) -> length (nub vs) == length vs) (zip [14..] (transpose (take 14 (tails i))))
