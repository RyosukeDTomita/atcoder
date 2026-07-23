-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_an
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (foldl')
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

-- 頂点1から全頂点への最短距離(辺数)を1回のBFSでまとめて求める。未到達は-1。
bfs :: Int -> Array Int [Int] -> Array Int Int
bfs n adjs = accumArray (\_ d -> d) (-1) (1, n) $ go Set.empty $ Seq.singleton (1, 0)
  where
    go :: Set.Set Int -> Seq.Seq (Int, Int) -> [(Int, Int)]
    go _ Seq.Empty = []
    go visited ((!v, !d) Seq.:<| rest)
      | Set.member v visited = go visited rest -- 到達リストを持っていることで、遠回りで到達したdが反映されず、最短経路を求められる。
      | otherwise =
          let neighbors = adjs ! v
              queue = foldl' (\q u -> q Seq.|> (u, d + 1)) rest neighbors
           in (v, d) : go (Set.insert v visited) queue

solve :: Int -> [[Int]] -> [Int]
solve n abList = elems (bfs n adjs)
  where
    adjs = accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map show $ solve n abList
