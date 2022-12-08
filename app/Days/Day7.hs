module Day7 where

import Data.List.Split
import Data.List
import Safe
import Data.Tree (flatten)

solve :: String -> (String, String)
solve input = (solvePartA input, solvePartB input)

data CommandType = Cd String | Ls deriving (Show, Eq)
data DirType = DirType String [FsNode] deriving (Show, Eq)
data FsNode = Dir DirType | File Int String deriving (Show, Eq)
data Line = Command CommandType | Output FsNode deriving (Show, Eq)
data SizedTree = SizedDir Int [SizedTree] | SizedFile Int deriving (Show, Eq)

getName :: FsNode -> String
getName (Dir (DirType name _)) = name
getName (File _ name) = name

parseCommand :: String -> CommandType
parseCommand ('c':'d':' ':rest) = Cd rest
parseCommand ('l':'s':_) = Ls

parseOutput :: String -> FsNode
parseOutput ('d':'i':'r':' ':dir_name) = Dir $ DirType dir_name []
parseOutput line = (\x -> File (read $ head x) (last x)) $ words line

parseLine :: String -> Line
parseLine ('$':' ':rest) = Command $ parseCommand rest
parseLine output = Output $ parseOutput output

updateParents :: [DirType] -> DirType -> [DirType]
updateParents [] node = []
updateParents parents node =
    let DirType name children = last parents
    in init parents ++ [DirType name (children ++ [Dir node])]

executeLine :: ([DirType], FsNode) -> Line -> ([DirType], FsNode)
executeLine (parents, node) (Command (Cd "/")) = (parents, node)
executeLine (parents, node) (Command (Cd "..")) = (init parents, Dir $ last parents)
executeLine (parents, Dir dir@(DirType _ children)) (Command (Cd folder)) = (parents ++ [dir], head $ filter (\child -> getName child == folder) children)
executeLine (parents, node) (Command Ls) = (parents, node)
executeLine (parents, Dir (DirType name children)) (Output output_node) =
    let new_node = DirType name (children ++ [output_node])
    in (updateParents parents new_node, Dir new_node)

getNum :: SizedTree -> Int
getNum (SizedDir size _) = size
getNum (SizedFile size) = size

getSizes :: FsNode -> SizedTree
getSizes (Dir (DirType name children)) =
    let children_sizes = map getSizes children
    in SizedDir (sum $ map getNum children_sizes) children_sizes
getSizes (File size _) = SizedFile size

solvePartA :: String -> String
solvePartA i = show $ getSizes $ Dir $ head $ fst $ foldl executeLine ([], Dir $ DirType "/" []) $ map parseLine $ lines i

solvePartB :: String -> String
solvePartB i = ""
