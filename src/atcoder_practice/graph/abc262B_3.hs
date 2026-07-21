-- https://atcoder.jp/contests/abc262/tasks/abc262_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.Set qualified as Set
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

-- 愚直だが、正しい方法
solve :: Int -> [[Int]] -> Int
solve n uvs =
  length
    [ (a, b, c)
    | a <- [1 .. n],
      b <- [a + 1 .. n],
      Set.member b (arr ! a), -- aとbが隣接
      c <- [b + 1 .. n],
      Set.member c (arr ! b), -- bとcが隣接
      Set.member c (arr ! a) -- cとaが隣接
    ]
  where
    arr = accumArray (flip Set.insert) Set.empty (1, n) $ concatMap (\[u, v] -> [(u, v), (v, u)]) uvs

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _m] = map read . words $ head ls :: [Int]
      uvs = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n uvs) ++ "\n"
