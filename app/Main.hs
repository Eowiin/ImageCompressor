{-
-- EPITECH PROJECT, 2022
-- ImageCompressor
-- File description:
-- Main.hs
-}

module Main (main) where

import System.Environment
import CheckArgs
import Conf
import System.Random
import ImageCompressor

main :: IO ()
main = do
    args <- getArgs
    let conf = checkArgs args defaultConf
    gen <- newStdGen
    if isConfInvalid conf
        then displayHelp
        else do
            content <- getContentFile (getValidConf conf)
            setupImageCompressor (getValidConf conf) gen content
