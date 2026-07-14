-- https://atcoder.jp/contests/abc116/tasks/abc116_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- Data.Setでprevsを持つべきではあるが、TLEしないのでいいや
solve :: Int -> Int
solve s = go [] $ zip [1 ..] (iterate f s)
  where
    go :: [Int] -> [(Int, Int)] -> Int
    go _ [] = error "unexpected"
    go prevs ((i, a) : rest)
      | a `elem` prevs = i
      | otherwise = go (a : prevs) rest
    f :: Int -> Int
    f n
      | even n = n `div` 2
      | otherwise = 3 * n + 1

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
