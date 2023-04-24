{- 
-- EPITECH PROJECT, 2022
-- ImageCompressor
-- File description:
-- ImageCompressor.hs
-}

module ImageCompressor (
    setupImageCompressor
) where

import Conf
import System.Random
import ParseFile
import Data.List (minimumBy)
import Data.Ord (comparing)

createClusters :: Int -> StdGen -> Out
createClusters 0 _ = []
createClusters n gen = (color, []):createClusters (n - 1) gen'
    where
        color = (r, g, b)
        (r, gen') = randomR (0, 255) gen
        (g, gen'') = randomR (0, 255) gen'
        (b, _) = randomR (0, 255) gen''

distance :: Color -> Color -> Float
distance (r1, g1, b1) (r2, g2, b2) = sqrt
    (fromIntegral (r + g + b))
    where
        r = (r1 - r2) ^ (2 :: Int)
        g = (g1 - g2) ^ (2 :: Int)
        b = (b1 - b2) ^ (2 :: Int)

addPixelToRightCluster :: Pixel -> Int -> Out -> Out
addPixelToRightCluster _ _ [] = []
addPixelToRightCluster px 0 ((color, points):clusters) =
    (color, px:points):clusters
addPixelToRightCluster px n (c:cs) = c:addPixelToRightCluster px (n - 1) cs

addPixelToCluster :: Pixel -> Out -> Out
addPixelToCluster _ [] = []
addPixelToCluster px clusters =
    addPixelToRightCluster px index clusters
    where
        index = getMinIndex (getDistances px clusters)

getMinIndex :: [Float] -> Int
getMinIndex xs = minimumBy (comparing (xs !!)) [0..(length xs - 1)]

getDistances :: Pixel -> Out -> [Float]
getDistances _ [] = []
getDistances px ((color, _):clusters) =
    (distance (snd px) color):getDistances px clusters

addPixelsToClusters :: In -> Out -> Out
addPixelsToClusters [] clusters = clusters
addPixelsToClusters (px:pxs) clusters = addPixelsToClusters pxs newClusters
    where
        newClusters = addPixelToCluster px clusters

moveCentroid :: Cluster -> Cluster
moveCentroid (color, []) = (color, [])
moveCentroid (_, pxs) = (newColor, [])
    where
        newColor = (r, g, b)
        r = div (sumPixels pxs 'r') (length pxs)
        g = div (sumPixels pxs 'g') (length pxs)
        b = div (sumPixels pxs 'b') (length pxs)

getNewClusters :: Out -> Out
getNewClusters [] = []
getNewClusters (cl:cls) = (moveCentroid cl):getNewClusters cls

getColorPixel :: Pixel -> Color
getColorPixel px = snd px

sumPixels :: In -> Char -> Int
sumPixels [] _ = 0
sumPixels (px:pxs) 'r' =
    let (r, _, _) = getColorPixel px in r + sumPixels pxs 'r'
sumPixels (px:pxs) 'g' =
    let (_, g, _) = getColorPixel px in g + sumPixels pxs 'g'
sumPixels (px:pxs) 'b' =
    let (_, _, b) = getColorPixel px in b + sumPixels pxs 'b'
sumPixels _ _ = 0

updateClusters :: In -> Out -> Out
updateClusters [] clusters = clusters
updateClusters px clusters = addPixelsToClusters px clusters

kmeansAlgorithm :: In -> Out -> Float -> Float -> Out
kmeansAlgorithm px clusters l x = if x < l
    then clusters
    else kmeansAlgorithm px newClusters l (x - 0.1)
    where
        newClusters = updateClusters px (getNewClusters clusters)

stringColor :: Color -> String
stringColor (r, g, b) =
    "(" ++ show r ++ ", " ++ show g ++ ", " ++ show b ++ ")"

stringPoint :: Point -> String
stringPoint (x, y) =
    "(" ++ show x ++ ", " ++ show y ++ ")"

displayPixels :: [Pixel] -> IO ()
displayPixels [] = return ()
displayPixels (px:pxs) =
    putStrLn (stringPoint (fst px) ++ " " ++ stringColor (snd px)) >>
    displayPixels pxs

displayClusters :: Out -> IO ()
displayClusters [] = return ()
displayClusters ((color, px):clusters) =
    putStrLn "--" >>
    putStrLn (stringColor color) >>
    putStrLn "-" >>
    displayPixels px >>
    displayClusters clusters

setupImageCompressor :: ValidConf -> StdGen -> String -> IO ()
setupImageCompressor (n, l, _) gen content =
    let output = kmeansAlgorithm px clusters l (l + 1)
    in displayClusters output
    where
        clusters = createClusters n gen
        px = contentToIn (lines content)
