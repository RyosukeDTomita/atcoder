-- https://atcoder.jp/contests/abc153/tasks/abc153_d
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
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

solve :: Int -> Int
solve n = go 0 [n]
  where
    go :: Int -> [Int] -> Int
    go acc [] = acc
    go acc (x : rest)
      | x == 1 = go (acc + 1) rest
      | otherwise = go (acc + 1) (halfx : halfx : rest)
      where
        !halfx = x `div` 2

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
