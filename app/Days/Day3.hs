module Day3 where

import Data.Char
import Data.List
import Data.List.Split

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

parseInputA :: String -> [(String, String)]
parseInputA input = map (\line -> splitAt ((length line + 1) `div` 2) line) $ lines input

getScore :: Char -> Int
getScore char = if char `elem` "abcdefghijklmnopqrstuvwxyz"
    then ord char - 96
    else ord char - 38

intersection:: (Eq a) => [[a]] -> [a]
intersection = foldr1 intersect

solvePartA :: String -> String
solvePartA i = show $ sum $ map (\(first, second) -> getScore $ head $ intersection [first, second]) $ parseInputA i

solvePartB :: String -> String
solvePartB i = show $ sum $ map (getScore . head . intersection) $ chunksOf 3 (lines i)
