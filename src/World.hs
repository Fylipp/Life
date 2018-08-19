module World where

import Util

data Cell = Dead | Alive deriving Show
type Grid = [[Cell]]
type Coord = (Int, Int)

step :: Grid -> Grid
step grid = matMap
    (\coord -> cellStep (cell grid coord) (aliveNeighbours grid coord))
    (coords grid)

coords :: Grid -> [[Coord]]
coords grid = map
    (\y -> map
        (\x -> (x, y))
        [0..width grid - 1])
    [0..height grid - 1]

cellStep :: Cell -> Int -> Cell
cellStep Alive 2 = Alive
cellStep _ 3 = Alive
cellStep _ _ = Dead

height grid = length grid
width grid = length $ grid !! 0

cell :: Grid -> Coord -> Cell
cell grid (x, y)
    | x < 0 = cell grid (width grid + x, y)
    | y < 0 = cell grid (x, height grid + y)
    | otherwise = grid !! (y `mod` (height grid)) !! (x `mod` (width grid))

normCoord :: Grid -> Coord -> Coord
normCoord grid (x, y)
    | x < 0 = normCoord grid (width grid + x, y)
    | y < 0 = normCoord grid (x, height grid + y)
    | otherwise = (x, y)

aliveNeighbours grid coord = foldl aggr 0 (neighbours grid coord)

aggr s Dead = s
aggr s Alive = s + 1

neighbours :: Grid -> Coord -> [Cell]
neighbours grid coord = map (\c -> cell grid c) (neighbourCoords coord)

neighbourCoords (x, y) =
    [
        ((x - 1), (y - 1)),
        (x, (y - 1)),
        ((x + 1), (y - 1)),
        ((x - 1), y),
        ((x + 1), y),
        ((x - 1), (y + 1)),
        (x, (y + 1)),
        ((x + 1), (y + 1))
    ]
