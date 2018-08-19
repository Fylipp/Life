module Util where

matMap :: (m -> a) -> [[m]] -> [[a]]
matMap f m = map
    (\row -> map (\c -> f c) row)
    m

splitEvery _ [] = []
splitEvery n list = first : (splitEvery n rest)
    where
    (first, rest) = splitAt n list
