module Day5 where

import Data.List.Split
import Data.List (sort, transpose, foldl')
import Control.Lens

type Board = [[Char]]

parseBoard :: String -> Board
parseBoard = map (filter (/= ' ')) . transpose . map ( map (!! 1) . chunksOf 4) . lines

data Instruction = Instruction {
    instMove :: Int,
    instFrom :: Int,
    instTo :: Int
} deriving Show

parseInstructions :: String -> [Instruction]
parseInstructions = map (
    \line ->
        let ws = words line
        in Instruction (read (ws !! 1)) (read (ws !! 3) - 1) (read (ws !! 5) - 1)
    ) . lines

applyInstruction :: Board -> Instruction -> Board
applyInstruction board inst =
    let (new, from_column) = splitAt (instMove inst) (board !! instFrom inst)
        to_column = reverse new ++ board !! instTo inst

    in board

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

parseInput :: String -> (Board, [Instruction])
parseInput input =
    let parts = splitOn "\n\n" input

    in (parseBoard $ head parts, parseInstructions $ last parts)

solvePartA :: String -> String
solvePartA i =
    let (board, instructions) = parseInput i

    in map head $ foldl' applyInstruction board instructions

solvePartB :: String -> String
solvePartB i = ""

