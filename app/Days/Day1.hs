module Day1 where

import Data.List.Split
import Data.List (sort)
import Control.Monad (replicateM)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

solvePartA :: String -> String
solvePartA input =
    let parts = lines input
        numbers = map read parts :: [Int]
        perms = replicateM 2 numbers
        output = product $ head $ filter (\x -> sum x == 2020) perms

    in show output

solvePartB :: String -> String
solvePartB input =
    let parts = lines input
        numbers = map read parts :: [Int]
        perms = replicateM 3 numbers
        output = product $ head $ filter (\x -> sum x == 2020) perms

    in show output
