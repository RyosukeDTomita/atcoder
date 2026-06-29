-- https://atcoder.jp/contests/abc007/tasks/abc007_3
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.Sequence qualified as Seq
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
solve r c sy sx gy gx css = bfs initialPaths Set.empty $ Seq.singleton (sy, sx)
  where
    arr = listArray ((1, 1), (r, c)) $ concat css -- findNeighborsでO(1)で要素にアクセスできるように変換。
    initialPaths = listArray ((1, 1), (r, c)) $ replicate (r * c) 0 -- スタートから何手で到達できるかを保存する
    bfs :: Array (Int, Int) Int -> Set.Set (Int, Int) -> Seq.Seq (Int, Int) -> Int
    bfs paths visited ((y, x) Seq.:<| rest)
      | (y, x) == (gy, gx) = paths ! (y, x)
      | Set.member (y, x) visited = bfs paths visited rest -- 訪問済みはskip
      | otherwise =
          let neighbors = findNeighbors (y, x)
              -- prev = dbgId $ paths ! (y, x)
              prev = paths ! (y, x)
              paths' = paths // zip neighbors (replicate (length neighbors) (prev + 1))
              visited' = Set.insert (y, x) visited -- NOTE: ここではneighborsには訪問していないので追加しない
              rest' = rest Seq.>< Seq.fromList neighbors -- queueに追加
           in bfs paths' visited' rest'
    findNeighbors :: (Int, Int) -> [(Int, Int)]
    findNeighbors (y, x) =
      [ (y', x')
        | (dy, dx) <- [(-1, 0), (1, 0), (0, -1), (0, 1)],
          let y' = y + dy,
          let x' = x + dx,
          y' >= 1, -- 1ステップマスを進ませる
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
