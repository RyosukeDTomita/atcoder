-- https://atcoder.jp/contests/abc121/tasks/abc121_c
-- foldl'版。短絡せず全要素を処理してみる
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl', sortOn)
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
solve m abList = fst $ foldl' go (0, 0) abTupleList
  where
    abTupleList = sortOn fst $ map (\[a, b] -> (a, b)) abList
    go :: (Int, Int) -> (Int, Int) -> (Int, Int)
    go (result, cnt) (a, b) =
      let n = min b (m - cnt)
       in (result + (n * a), cnt + n)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve m abList) ++ "\n"
