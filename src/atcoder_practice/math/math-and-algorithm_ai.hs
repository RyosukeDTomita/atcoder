-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_ai
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (scanl')
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

solve :: Int -> [Int] -> [[Int]] -> [Int]
solve n as lrs = map (\[l, r] -> prefixSum ! r - prefixSum ! (l - 1)) lrs
  where
    prefixSum = listArray (0, n) $ scanl' (+) 0 as -- nが10^5まであったのでArrryにしてi番目取得をO(1)にした。

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, q] = map read . words $ head ls :: [Int]
      as = map read . words $ ls !! 1 :: [Int]
      lrs = map (map read . words) $ drop 2 ls :: [[Int]]
   in unlines $ map show $ solve n as lrs
