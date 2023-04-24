{-
-- EPITECH PROJECT, 2022
-- ImageCompressor
-- File description:
-- Conf.hs
-}

module Conf (
    Conf,
    ValidConf,
    Cluster,
    Color,
    Point,
    Pixel,
    In,
    Out,
    defaultConf,
    isConfInvalid,
    getValidConf
) where

type Conf = (Maybe Int, Maybe Float, Maybe String)
type ValidConf = (Int, Float, String)

type Cluster = (Color, [Pixel])
type Color = (Int, Int, Int)
type Point = (Int, Int)
type Pixel = (Point, Color)
type In = [Pixel]
type Out = [Cluster]

defaultConf :: Conf
defaultConf = (Nothing, Nothing, Nothing)

isConfInvalid :: Conf -> Bool
isConfInvalid (Nothing, _, _) = True
isConfInvalid (_, Nothing, _) = True
isConfInvalid (_, _, Nothing) = True
isConfInvalid _ = False

getValidConf :: Conf -> ValidConf
getValidConf (Just n, Just l, Just f) = (n, l, f)
getValidConf _ = error "Conf is invalid"
