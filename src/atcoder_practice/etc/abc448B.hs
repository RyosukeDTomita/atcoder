-- https://atcoder.jp/contests/abc448/tasks/abc448_b
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (mapAccumL)
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

-- | list xsのi番目をxに更新する
setAt :: Int -> a -> [a] -> [a]
setAt i x xs =
  let (before, after) = splitAt i xs
   in before ++ x : tail after

solve :: [Int] -> [[Int]] -> Int
solve cs abList = sum $ snd $ mapAccumL go cs abList
  where
    go :: [Int] -> [Int] -> ([Int], Int)
    go stock [a, b] =
      let ca = stock !! (a - 1)
          use = min ca b -- 限界までストックの胡椒を使う。
       in if ca > 0 then (setAt (a - 1) (ca - use) stock, use) else (stock, 0)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      -- [n, m] = map read . words $ head ls :: [Int]
      cs = map read . words $ ls !! 1 :: [Int]
      abList = map (map read . words) $ drop 2 ls :: [[Int]]
   in show (solve cs abList) ++ "\n"
