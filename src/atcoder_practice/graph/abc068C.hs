-- https://atcoder.jp/contests/abc068/tasks/arc079_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
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

solve :: Int -> [[Int]] -> String
solve n abList = if any searchN canGoFromStart then "POSSIBLE" else "IMPOSSIBLE"
  where
    arr = accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList
    canGoFromStart = arr ! 1 -- 1から行ける島のリスト
    -- 島iから島nにいけるか
    searchN :: Int -> Bool
    searchN i = n `elem` arr ! i

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int] -- nは目的の地点
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in (solve n abList) ++ "\n"
