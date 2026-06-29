-- https://atcoder.jp/contests/typical90/tasks/typical90_bz
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
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

solve :: Int -> [[Int]] -> Int
solve n abList = length $ filter check arrList
  where
    arr = accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList
    arrList = assocs arr
    check :: (Int, [Int]) -> Bool
    check (i, xs) = length (filter (< i) xs) == 1

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n abList) ++ "\n"
