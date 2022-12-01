module Day1 where

import Data.List.Split
import Data.List (sort)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

solvePartA :: String -> String
solvePartA = show . maximum . map (sum . map read . lines) . splitOn "\n\n"

solvePartB :: String -> String
solvePartB = show . sum . take 3 . reverse . sort . map (sum . map read . lines) . splitOn "\n\n"
