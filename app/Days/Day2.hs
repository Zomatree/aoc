module Day2 where

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

data Shape = Rock | Paper | Scissors
shapeFromChar 'A' = Rock
shapeFromChar 'B' = Paper
shapeFromChar 'C' = Scissors
shapeFromChar 'X' = Rock
shapeFromChar 'Y' = Paper
shapeFromChar 'Z' = Scissors

shapeToInt :: Shape -> Int
shapeToInt Rock = 1
shapeToInt Paper = 2
shapeToInt Scissors = 3

shapeFromOutcome :: Shape -> Outcome -> Shape
shapeFromOutcome Rock Win = Paper
shapeFromOutcome Rock Loose = Scissors
shapeFromOutcome Rock Draw = Rock
shapeFromOutcome Paper Win = Scissors
shapeFromOutcome Paper Loose = Rock
shapeFromOutcome Paper Draw = Paper
shapeFromOutcome Scissors Win = Rock
shapeFromOutcome Scissors Loose = Paper
shapeFromOutcome Scissors Draw = Scissors

data Outcome = Win | Loose | Draw

doesWin :: Shape -> Shape -> Outcome
doesWin Rock Rock = Draw
doesWin Rock Paper = Loose
doesWin Rock Scissors = Win
doesWin Paper Rock = Win
doesWin Paper Paper = Draw
doesWin Paper Scissors = Loose
doesWin Scissors Rock = Loose
doesWin Scissors Paper = Win
doesWin Scissors Scissors = Draw

outcomeFromChar :: Char -> Outcome
outcomeFromChar 'X' = Loose
outcomeFromChar 'Y' = Draw
outcomeFromChar 'Z' = Win

toPoints :: Shape -> Outcome -> Int
toPoints shape Win = 6 + shapeToInt shape
toPoints shape Loose = 0 + shapeToInt shape
toPoints shape Draw = 3 + shapeToInt shape

parseInputA :: String -> [(Shape, Shape)]
parseInputA = map (
    \line -> (shapeFromChar $ head line, shapeFromChar $ last line)
    ) . lines

parseInputB :: String -> [(Shape, Outcome)]
parseInputB = map (
    \line -> (shapeFromChar $ head line, outcomeFromChar $ last line)
    ) . lines

solvePartA :: String -> String
solvePartA i = show $ sum $ map (\(opp, you) -> toPoints you $ doesWin you opp) $ parseInputA i

solvePartB :: String -> String
solvePartB i = show $ sum $ map (\(opp, outcome) -> toPoints (shapeFromOutcome opp outcome) outcome ) $ parseInputB i
