{- 
-- EPITECH PROJECT, 2022
-- ImageCompressor
-- File description:
-- CheckArgs.hs
-}

module CheckArgs (
    getParams,
    checkArgs,
    displayHelp,
    getContentFile
) where

import Conf
import System.Exit
import Text.Read
import Control.Exception

getContentFile :: ValidConf -> IO String
getContentFile (_, _, f) = catch (readFile f) (\e ->
    let err = show (e :: IOException) in
    putStrLn ("Error: " ++ err) >> exitWith (ExitFailure 84))

getParams :: [String] -> Conf -> Conf
getParams [] conf = conf
getParams ("-n":x:xs) (_, l, f) = getParams xs (readMaybe x, l, f)
getParams ("-l":x:xs) (n, _, f) = getParams xs (n, readMaybe x, f)
getParams ("-f":x:xs) (n, l, _) = getParams xs (n, l, Just x)
getParams (_:_) _ = defaultConf

checkArgs :: [String] -> Conf -> Conf
checkArgs [] dconf = dconf
checkArgs x dconf = if length x `mod` 2 /= 0
    then dconf else getParams x dconf

displayHelp :: IO ()
displayHelp = putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n" >>
    putStrLn "\tN\t\tnumber of colors in the final image" >>
    putStrLn "\tL\t\tconvergence limit" >>
    putStrLn "\tF\t\tpath to the file containing the colors of the pixels" >>
    exitWith (ExitFailure 84)
