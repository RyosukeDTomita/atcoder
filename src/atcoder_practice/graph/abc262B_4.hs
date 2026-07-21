-- https://atcoder.jp/contests/abc262/tasks/abc262_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (tails)
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

-- aの隣接リストから重複しない形でbとcを取り出し、bとcが隣接なら答えとする
-- tails [1,2,3,4]
-- [[1,2,3,4],[2,3,4],[3,4],[4],[]] この要素1つごとに(b: rest)を作るイメージ
solve :: Int -> [[Int]] -> Int
solve n uvs =
  length
    [ (a, b, c)
    | a <- [1 .. n],
      (b : !rest) <- dbgId $ tails $ filter (> a) (Set.toList (arr ! a)), -- aの隣接頂点からa以上の最小をb
      c <- rest, -- bより後ろの候補なのでb<cが確定
      Set.member c (arr ! b) -- bとcが隣接
    ]
  where
    arr = accumArray (flip Set.insert) Set.empty (1, n) $ concatMap (\[u, v] -> [(u, v), (v, u)]) uvs

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _m] = map read . words $ head ls :: [Int]
      uvs = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n uvs) ++ "\n"
