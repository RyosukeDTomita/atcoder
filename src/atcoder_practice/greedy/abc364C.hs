-- https://atcoder.jp/contests/abc364/tasks/abc364_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (sortOn)
import Data.Ord (Down (..))
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

binarySearch :: Int -> Int -> (Int -> Bool) -> Int
binarySearch ok ng f
  | abs (ok - ng) <= 1 = ok -- これが最小の値
  | f mid = binarySearch mid ng f
  | otherwise = binarySearch ok mid f
  where
    mid = (ok + ng) `div` 2

solve :: Int -> Int -> Int -> [Int] -> [Int] -> Int
solve n x y as bs = binarySearch n 0 check
  where
    as' = sortOn Down as
    bs' = sortOn Down bs
    -- i個でこれ以上食べられなくなるか
    check :: Int -> Bool
    check i
      | x < (sum . take i) as' = True
      | y < (sum . take i) bs' = True
      | otherwise = False

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, x, y] = map read . words $ head ls :: [Int]
        as = map read . words $ ls !! 1 :: [Int]
        bs = map read . words $ ls !! 2 :: [Int]
     in show (solve n x y as bs) ++ "\n"
