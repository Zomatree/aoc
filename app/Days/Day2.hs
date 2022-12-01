module Day2 where

import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import qualified Data.Text as T
import Control.Monad (void)
import Data.Either (rights, lefts)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

type Parser = Parsec Void String

data Line = Line {
    lineStart :: Int,
    lineEnd :: Int,
    lineChar :: Char,
    lineText :: String
} deriving Show

expr :: Parser Line
expr = do
    start <- L.decimal
    void (char '-')
    end <- L.decimal
    void (char ' ')
    text_char <- head <$> some alphaNumChar
    void (char ':')
    void (char ' ')
    text <- some alphaNumChar
    return Line {lineStart=start, lineEnd=end, lineChar=text_char, lineText=text}

solvePartA :: String -> String
solvePartA input =
    let all_lines = lines input
        exprs = rights $ map (parse expr "<input>") all_lines

    in show $ length $ filter (
        \line ->
            let count = length $ filter (\c -> c == lineChar line) (lineText line)
            in count >= lineStart line && lineEnd line >= count
        ) exprs

solvePartB :: String -> String
solvePartB input =
    let all_lines = lines input
        exprs = rights $ map (parse expr "<input>") all_lines

    in show $ length $ filter (
        \line ->
            let text = lineText line
                char = lineChar line
                start_eq = text !! (lineStart line - 1) == char
                end_eq = text !! (lineEnd line - 1) == char

            in (start_eq && not end_eq) || (not start_eq && end_eq)
        ) exprs
