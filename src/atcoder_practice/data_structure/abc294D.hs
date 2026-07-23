-- https://atcoder.jp/contests/abc294/tasks/abc294_d
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
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

thd :: (a, b, c) -> c
thd (_, _, c) = c

solve :: Int -> [[Int]] -> [Int]
solve n qs = reverse $ thd $ foldl' go (Set.empty, [1 .. n], []) qs
  where
    -- called: 受付に1回以上呼ばれた人(受付に行った人は削除する)
    -- notCalled: まだ一度も呼ばれてない待機列
    go :: (Set.Set Int, [Int], [Int]) -> [Int] -> (Set.Set Int, [Int], [Int])
    go (called, notCalled, output) (i : x)
      | i == 1 = (Set.insert (head notCalled) called, tail notCalled, output)
      | i == 2 = (Set.delete (head x) called, notCalled, output)
      | i == 3 = (called, notCalled, Set.findMin called : output)
      | otherwise = error "input is not valiid"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, q] = map read . words $ head ls :: [Int]
      es = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines $ map show $ solve n es
