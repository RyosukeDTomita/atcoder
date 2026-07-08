-- https://atcoder.jp/contests/abc166/tasks/abc166_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (foldl')
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

solve :: Int -> [Int] -> [[Int]] -> Int
solve n hs abList = foldl' go 0 $ assocs arr
  where
    arr = accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList -- 無効グラフ
    decks = listArray (1, n) hs -- 灯台の高さ
    go :: Int -> (Int, [Int]) -> Int
    go acc (i, adj)
      | null adj = acc + 1
      | decks ! i > maximum (map (decks !) adj) = acc + 1
      | otherwise = acc

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      hs = map read . words $ ls !! 1 :: [Int]
      abList = map (map read . words) $ drop 2 ls :: [[Int]]
   in show (solve n hs abList) ++ "\n"
