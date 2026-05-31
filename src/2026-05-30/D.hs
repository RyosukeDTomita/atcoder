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

-- 10^100 回 (偶数回) 後の最終形を求める。
-- ・source = 「白マスに隣接する初期の黒マス」(黒領域の境界)。
--   (周囲がすべて黒の内部マスや、孤立した黒マスは source にならない)
-- ・最終的に黒 ⟺ 最も近い source へのチェビシェフ距離が偶数。
-- ・source が 1 つも無ければ全マス白。
-- これを 8 近傍の多始点 BFS の層として求め、偶数層のマスを '#' とする。
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
    blacks =
      [ i * w + j
        | (i, row) <- zip [0 ..] ss,
          (j, c) <- zip [0 ..] (BS.unpack row),
          c == '#'
      ]
    blackSet = IntSet.fromList blacks
    -- source = 盤面内に白の隣接マスを持つ黒マス (黒領域の境界)
    sources = filter (\idx -> any (`IntSet.notMember` blackSet) (neighbors idx)) blacks
    -- フラット添字 idx の 8 近傍 (盤面内のみ)
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
    -- フロンティアの隣接マスのうち未訪問のものを次の層として返す (重複も除去)
    expand visited frontier =
      foldl' add ([], visited) (concatMap neighbors frontier)
      where
        add (acc, vis) n
          | IntSet.member n vis = (acc, vis)
          | otherwise = (n : acc, IntSet.insert n vis)
    -- 層ごとにBFSし、偶数層に入ったマスを集める
    bfs visited frontier isEven acc
      | null frontier = acc
      | otherwise =
          let acc' = if isEven then foldl' (flip IntSet.insert) acc frontier else acc
              (next, visited') = expand visited frontier
           in bfs visited' next (not isEven) acc'
    evenCells = bfs (IntSet.fromList sources) sources True IntSet.empty

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [h, w] = map readInt . BS.words $ head ls :: [Int]
        ss = drop 1 ls
     in BS.unlines $ solve h w ss
