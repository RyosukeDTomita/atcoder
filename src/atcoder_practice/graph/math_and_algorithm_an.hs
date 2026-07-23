-- WA
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

bfs :: Int -> Array Int (Set.Set Int) -> Maybe [Int]
bfs goal adjs =
  let paths = takeWhile (/= goal) $ go Set.empty (Seq.singleton 1)
   in if null paths then Nothing else Just paths
  where
    go :: Set.Set Int -> Seq.Seq Int -> [Int]
    go _ Seq.Empty = []
    go visited (v Seq.:<| rest)
      | Set.member v visited = go visited rest
      | otherwise =
          let neighbors = adjs ! v
              queue = foldl' (Seq.|>) rest neighbors
           in v : go (Set.insert v visited) queue -- 　bfsではあるが、最短経路を求められていない。

solve :: Int -> [[Int]] -> [Int]
solve n abList = foldl' go [0] [2 .. n] -- 1から1に行くのは0で確定なので先に埋めてく
  where
    adjs = accumArray (flip Set.insert) Set.empty (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList
    go :: [Int] -> Int -> [Int]
    go acc i = case bfs i adjs of
      Just paths -> length paths : acc
      Nothing -> (-1) : acc

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map show $ solve n abList
