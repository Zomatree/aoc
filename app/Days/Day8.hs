module Day8 where

import Data.List.Split
import Data.List (sort)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

isVisibile :: [[Char]] -> (Int, Int) -> Bool
isVisibile board (x, y) =
    let c = board !! y !! x
    in (all (\(p_x, p_y) -> (board !! y !! x) < c) [0..x])

solvePartA :: String -> String
solvePartA i =
    let board = lines i

    in show $ length $ filter (isVisibile board) $ concat $ [[(x, y) | x <- [1..length (head board) - 2]] | y <- [1..length board - 2]]

solvePartB :: String -> String
solvePartB = show . sum . take 3 . reverse . sort . map (sum . map read . lines) . splitOn "\n\n"
