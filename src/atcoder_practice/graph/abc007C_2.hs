-- https://atcoder.jp/contests/abc007/tasks/abc007_3
{-# LANGUAGE CPP #-}
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

solve :: Int -> Int -> Int -> Int -> Int -> Int -> [String] -> Int
solve r c sy sx gy gx css = bfs 0 start start
  where
    arr = listArray ((1, 1), (r, c)) $ concat css
    start = Set.singleton (sy, sx)
    -- 距離dのフロンティア(同時到達マスの集合)を一段ずつ広げる。再帰の深さで距離を管理することで、Arrayでマスごとの到達距離の更新をしなくてよい。
    bfs :: Int -> Set.Set (Int, Int) -> Set.Set (Int, Int) -> Int
    bfs d visited frontier
      | Set.member (gy, gx) frontier = d -- ゴールを訪問済みのときの深さ
      | otherwise = bfs (d + 1) visited' frontier'
      where
        -- 現フロンティアの四近傍のうち未訪問の空きマスが次のフロンティア
        frontier' =
          Set.fromList
            [ next
            | cell <- Set.toList frontier,
              next <- findNeighbors cell, -- 1ステップマスを進ませる
              Set.notMember next visited -- ここで訪問済みは外すとキューの連結コストを考えてData.Sequenceを使う必要がなくてうれしい
            ]
        visited' = Set.union visited frontier'
    findNeighbors :: (Int, Int) -> [(Int, Int)]
    findNeighbors (y, x) =
      [ (y', x')
      | (dy, dx) <- [(-1, 0), (1, 0), (0, -1), (0, 1)],
        let y' = y + dy,
        let x' = x + dx,
        y' >= 1,
        y' <= r, -- 範囲外アクセス抑止
        x' >= 1,
        x' <= c, -- 範囲外アクセス抑止
        arr ! (y', x') /= '#'
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [r, c] = map read . words $ head ls :: [Int]
      [sy, sx] = map read . words $ ls !! 1 :: [Int]
      [gy, gx] = map read . words $ ls !! 2 :: [Int]
      css = drop 3 ls
   in show (solve r c sy sx gy gx css) ++ "\n"
