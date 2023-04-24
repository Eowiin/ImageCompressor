{-
-- EPITECH PROJECT, 2022
-- imageCompressor
-- File description:
-- ParseFile.hs
-}

module ParseFile (
    toPoint,
    toColor,
    contentToIn
) where

import Conf
import Data.Char (isDigit)

toPoint :: [Int] -> Point
toPoint nbs = ((nbs !! 0), (nbs !! 1))

toColor :: [Int] -> Color
toColor nbs = ((nbs !! 2), (nbs !! 3), (nbs !! 4))

stringToIntList :: String -> [Int]
stringToIntList s =
    case foldr go ([], "") s of
        ([], _) -> []
        (acc, "") -> (map read acc)
        (acc, n) -> (map read (n:acc))
    where
        go c (acc, num) | isDigit c = (acc, c:num)
                        | otherwise = case num of
                            "" -> (acc, num)
                            _ -> (num:acc, "")

contentToIn :: [String] -> In
contentToIn [] = []
contentToIn (x:xs) = (point, color):contentToIn xs
    where
        nbs = stringToIntList x
        point = toPoint nbs
        color = toColor nbs
