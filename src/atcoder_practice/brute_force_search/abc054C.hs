-- https://atcoder.jp/contests/abc054/tasks/abc054_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (permutations)
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
solve n abList = length $ filter id $ map checkPath perms -- filter idでTrueのリストだけを作れる
-- ghci> filter id [True, False, True]
-- [True,True]
  where
    !perms = map (\rest -> 1 : rest) (permutations [2 .. n]) -- 問題文の制約で1スタートは決まっている
    -- \| 経路を辺に変換。単に[1,2,3,4]を[[1,2],[3,4]]に分けると2 -> 3の経路が消えてしまうので注意。
    chunk2 :: [Int] -> [[Int]]
    chunk2 path = zipWith (\a b -> [a, b]) path $ tail path
    -- 現在の頂点と辺で指定された経路を使用できるか
    checkPath :: [Int] -> Bool
    checkPath path = foldr (\ab acc -> go acc ab && acc) True $ chunk2 path
      where
        go :: Bool -> [Int] -> Bool
        go acc [a, b] = [a, b] `elem` abList || [b, a] `elem` abList -- 無向グラフなので、反対方向の検証も必要

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      ![n, _] = map read . words $ head ls :: [Int] -- n頂点、m辺
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n abList) ++ "\n"
