-- https://atcoder.jp/contests/abc121/tasks/abc121_c
-- accを評価せずに、foldrではうまく短絡できなかった。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (sortOn)
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
solve m abList = fst $ go (0, 0) abTupleList
  where
    abTupleList = sortOn fst $ map (\[a, b] -> (a, b)) abList
    go :: (Int, Int) -> [(Int, Int)] -> (Int, Int)
    go (!result, !cnt) _
      | cnt == m = (result, cnt)
    go (!result, !cnt) ((a, b) : rest) =
      let n = min b (m - cnt)
       in go (result + (n * a), cnt + n) rest

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve m abList) ++ "\n"
