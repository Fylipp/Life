{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import World
import Util

import System.Environment (getArgs, getProgName)
import System.Directory (createDirectoryIfMissing)

import Control.Monad

import Data.Word (Word8)
import Data.Vector.Storable (toList)

import Codec.Picture (
        readPng, generateImage, imageData, imageWidth, savePngImage,
        DynamicImage(..), Image
    )

import Codec.Picture.Types (PixelRGB8(..))


main :: IO ()
main = do
    args <- getArgs
    progName <- getProgName

    if not $ length args == 3
    then
        error $ "Usage: " ++ progName ++ " <ITERATIONS> <INITIAL_STATE_FILE> <OUTPUT_FOLDER>"
    else do
        let iters :: Int = read $ args !! 0
        let initialStateFile = args !! 1
        let outputFolder = args !! 2

        createDirectoryIfMissing True outputFolder

        eimg <- readPng initialStateFile
        case eimg of
            Left err -> error err
            Right (ImageRGB8 img) -> do
                let pixels = toList $ imageData img
                let cells = map cellState $ map (\[r, g, b] -> (r, g, b)) (splitEvery 3 pixels)
                let grid = splitEvery (imageWidth img) cells

                iter grid 0 iters outputFolder

                return ()
            Right _ -> error "Unknown pixel format"

iter :: Grid -> Int -> Int -> String -> IO ()
iter grid gen last outputFolder = do
    if gen > last then return () else do
        let img = ImageRGB8 $ gridToImg grid
        savePngImage (outputFolder ++ "/" ++ (show gen) ++ ".png") img
        iter (step grid) (gen + 1) last outputFolder

gridToImg :: Grid -> Image PixelRGB8
gridToImg grid = generateImage (\x y -> pixel (cell grid (x, y))) (width grid) (height grid)

pixel :: Cell -> PixelRGB8
pixel Dead = PixelRGB8 255 255 255
pixel Alive = PixelRGB8 0 0 0

cellState :: (Word8, Word8, Word8) -> Cell
cellState (0, 0, 0) = Alive
cellState _ = Dead

gridToStr :: Grid -> String
gridToStr grid = tail(
        foldl
        (\l r -> l ++ "\n" ++ r)
        ""
        (map
            (\row -> tail (foldl (\l r -> l ++ " " ++ r) "" row))
            (matMap cellToStr grid)))

cellToStr Alive = "X"
cellToStr Dead = "_"
