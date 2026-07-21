-- https://atcoder.jp/contests/abc262/tasks/abc262_b
-- WAになる
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

solve :: Int -> [[Int]] -> Int
solve n uvs = (foldl' go 0 [1 .. n]) `div` 6 -- 重複カウントを防ぐため/3!している
  where
    arr = accumArray (flip Set.insert) Set.empty (1, n) $ concatMap (\[u, v] -> [(u, v), (v, u)]) uvs
    go :: Int -> Int -> Int
    go acc a =
      let bs = arr ! a -- aの隣接リスト(b候補)
          n = foldl' (\ac b -> if Set.member a (arr ! b) then ac + 1 else ac) 0 bs -- bの隣接リストにaを含むものの数 -> このロジックが間違っている!
       in acc + n

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      uvs = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n uvs) ++ "\n"
