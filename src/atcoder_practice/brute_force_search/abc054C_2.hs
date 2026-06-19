-- https://atcoder.jp/contests/abc054/tasks/abc054_c
{-# OPTIONS_GHC -Wno-x-partial #-}

import Data.List (permutations)
import Data.Set qualified as Set

-- 頂点1始点のハミルトンパス(全頂点をちょうど1回訪れる経路)の総数を数える。
solve :: Int -> [[Int]] -> Int
solve n abList = length (filter valid perms)
  where
    -- 無向グラフなので両方向の辺をSetに登録し、member判定を O(log) にする。 -> 対して早くはならなかったw
    edges :: Set.Set (Int, Int)
    edges =
      Set.fromList
        [ (u, v)
        | [a, b] <- abList,
          (u, v) <- [(a, b), (b, a)]
        ]
    perms = map (1 :) (permutations [2 .. n])
    -- \| 隣接ペア (path と tail path のzip) がすべて辺として存在するか。
    valid :: [Int] -> Bool
    -- allは and $ map f xsのように使えるのでfoldrしていた部分を簡潔に書ける
    valid path = all (`Set.member` edges) $ zip path (tail path) -- 前の引数を空けるために中置で`Set.member`している

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _] = map read . words $ head ls :: [Int] -- n頂点、m辺
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n abList) ++ "\n"
