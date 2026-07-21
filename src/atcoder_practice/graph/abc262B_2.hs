-- https://atcoder.jp/contests/abc262/tasks/abc262_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (foldl')
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

-- 誤った実装
solve :: Int -> [[Int]] -> Int
solve n uvs = (foldl' go 0 [1 .. n]) `div` 6 -- 重複排除のため3!で割る
  where
    arr = accumArray (flip Set.insert) Set.empty (1, n) $ concatMap (\[u, v] -> [(u, v), (v, u)]) uvs
    go :: Int -> Int -> Int
    go acc a =
      let adj = arr ! a
       in acc + (Set.size $ Set.filter (\x -> Set.member x (arr ! x)) adj) -- つねに0になってしまう。bの隣接リストにbは含まれないことを検証してしまっている。

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _m] = map read . words $ head ls :: [Int]
      uvs = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n uvs) ++ "\n"
