-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.IntSet qualified as IntSet
import Data.List (foldl')
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- 以下解説抜粋 https://atcoder.jp/contests/abc460/editorial/21027
-- ある時点で黒く塗られ、隣接する白マスが存在するようなマスはその後操作をするたびに黒く塗られた状態と白く塗られた状態を交互に繰り返す
-- つまり、1回の操作後に黒マスは隣接する白マスを持つ。
-- はじめてマスが黒く塗られるタイミングの偶奇がわかればよい。
-- 初めてマスが黒く塗られるまでには最も近い黒マスからのチェビシェフ距離と同じだけの操作回数がかかり、これは（多始点）BFS により求めることができる
--
-- source = 「白マスに隣接する初期の黒マス」(黒領域の境界)。
--   (周囲がすべて黒の内部マスや、孤立した黒マスは source にならない)
-- 最終的に黒 最も近いsourceへのチェビシェフ距離が偶数。
-- source が1つも無ければ全マス白。
solve :: Int -> Int -> [BS.ByteString] -> [BS.ByteString]
solve h w ss =
  [ BS.pack
      [ if IntSet.member (i * w + j) evenCells then '#' else '.'
        | j <- [0 .. w - 1]
      ]
    | i <- [0 .. h - 1]
  ]
  where
    -- 初期の黒マスをフラットな添字に変換
    blacks :: [Int]
    blacks =
      [ i * w + j
        | (i, row) <- zip [0 ..] ss,
          (j, c) <- zip [0 ..] (BS.unpack row),
          c == '#'
      ]
    blackSet = IntSet.fromList blacks
    -- 各黒マスに対して周囲8マスをもとめ、それが白いマス
    sources = filter (\idx -> any (`IntSet.notMember` blackSet) (neighbors idx)) blacks
    -- sourceからの距離が偶数のマス
    evenCells = bfs (IntSet.fromList sources) sources True IntSet.empty
    -- ----------Function----------
    -- フラット添字 idx の 8 近傍 (盤面内のみ)
    neighbors :: Int -> [Int]
    neighbors idx =
      let (i, j) = idx `quotRem` w
       in [ i' * w + j'
            | di <- [-1, 0, 1],
              dj <- [-1, 0, 1],
              (di, dj) /= (0, 0),
              let i' = i + di,
              let j' = j + dj,
              i' >= 0,
              i' < h,
              j' >= 0,
              j' < w
          ]
    -- 層=sourceからのBFS距離が同じマスのグループ
    -- 層ごとにBFSし、偶数層に入ったマスを集める
    -- isEven: 現在処理しているのが偶数距離にあるマスか
    bfs :: IntSet.IntSet -> [Int] -> Bool -> IntSet.IntSet -> IntSet.IntSet
    bfs visited frontier isEven acc
      | null frontier = acc
      | otherwise =
          -- acc=次の層
          -- visited=訪問済み集合
          let acc' = if isEven then foldl' (flip IntSet.insert) acc frontier else acc
              (next, visited') = expand visited frontier
           in bfs visited' next (not isEven) acc'
    -- 層の隣接マスのうち未訪問のものを次の層として返す
    expand :: IntSet.IntSet -> [Int] -> ([Int], IntSet.IntSet)
    expand visited frontier =
      foldl' add ([], visited) (concatMap neighbors frontier)
      where
        add :: ([Int], IntSet.IntSet) -> Int -> ([Int], IntSet.IntSet)
        add (acc, vis) n
          | IntSet.member n vis = (acc, vis)
          | otherwise = (n : acc, IntSet.insert n vis)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [h, w] = map readInt . BS.words $ head ls :: [Int]
        ss = drop 1 ls
     in BS.unlines $ solve h w ss
