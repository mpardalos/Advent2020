{-# LANGUAGE FlexibleContexts #-}
module Common where

import Data.Map (Map)
import Text.Parsec
import Data.Functor.Identity

type Solution = String -> IO ()

-- | Other functions to offer on the cli
type Extra = String -> IO ()
type Extras = Map String (String -> IO ())

at :: [a] -> Int -> Maybe a
at [] _ = Nothing
at (x:xs) 0 = Just x
at (x:xs) n = at xs (n-1)

slice :: Int -> Int -> [Int] -> [Int]
slice start end = drop start . take end

indexedMap :: (Int -> a -> b) -> [a] -> [b]
indexedMap f xs = zipWith f [0..length xs - 1] xs

count :: Eq a => a -> [a] -> Int
count y = length . filter (==y)

untilFixed :: Eq a => (a -> a) -> a -> a
untilFixed f val =
  let val' = f val in
    if val == val'
    then val
    else untilFixed f val'

next :: (Enum a, Bounded a, Eq a) => a -> a
next x | x == maxBound = minBound
       | otherwise = succ x

prev :: (Enum a, Bounded a, Eq a) => a -> a
prev x | x == minBound = maxBound
       | otherwise = pred x

atMay :: [a] -> Int -> Maybe a
atMay [] _ = Nothing
atMay (x:_) 0 = Just x
atMay (_:xs) n | n < 0 = Nothing
               | otherwise = atMay xs (n-1)
