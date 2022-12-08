module Day8 where

import Data.List.Split
import Data.List (sort)
import Data.Char (digitToInt)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

always :: a -> [a]
always i = [i | _ <- [0..]]

getIndex :: [[Int]] -> (Int, Int) -> Int
getIndex board (x, y) = board !! y !! x

isSmaller :: [[Int]] -> Int -> (Int, Int) -> Bool
isSmaller board c coords = getIndex board coords < c

isVisibile :: [[Int]] -> (Int, Int) -> Bool
isVisibile board (x, y) =
    let c = board !! y !! x
    in all (isSmaller board c) (zip [0..x - 1] (always y)) ||
       all (isSmaller board c) (zip [x + 1..length (head board) - 1] (always y)) ||
       all (isSmaller board c) (zip (always x) [0..y - 1]) ||
       all (isSmaller board c) (zip (always x) [y + 1..length board - 1])


calculateSingleLine :: Int -> [Int] -> Int
calculateSingleLine n numbers = 0

calculateScenicScore :: [[Int]] -> (Int, Int) -> Int
calculateScenicScore board (x, y) =
    let c = board !! y !! x
        zip_f = zipWith (curry (getIndex board))

    in product [calculateSingleLine c (zip_f [0..x - 1] (always y)),
                calculateSingleLine c (zip_f [x + 1..length (head board) - 1] (always y)),
                calculateSingleLine c (zip_f (always x) [0..y - 1]),
                calculateSingleLine c (zip_f (always x) [y + 1..length board - 1])]

solvePartA :: String -> String
solvePartA i =
    let board = map (map digitToInt) $ lines i
        borders = (2 * length board) + (2 * length (head board)) - 4

    in show $ length (filter (isVisibile board) $ concat $ [[(x, y) | x <- [1..length (head board) - 2]] | y <- [1..length board - 2]]) + borders

solvePartB :: String -> String
solvePartB i =
    let board = map (map digitToInt) $ lines i
        borders = (2 * length board) + (2 * length (head board)) - 4

    in show $ maximum (map (calculateScenicScore board) $ concat $ [[(x, y) | x <- [1..length (head board) - 2]] | y <- [1..length board - 2]]) + borders
