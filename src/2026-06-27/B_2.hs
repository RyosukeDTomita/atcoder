-- https://atcoder.jp/contests/abc464/submissions/76993658 に影響を受けて再実装
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (transpose)
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

solve :: [String] -> [String]
solve css = (transpose . deleteAbove . reverse . deleteAbove . reverse . transpose . reverse . deleteAbove . reverse . deleteAbove) css
  where
    deleteAbove :: [String] -> [String]
    deleteAbove xss = dropWhile (all (== '.')) xss

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      -- [h, w] = map read . words $ head ls :: [Int]
      css = tail ls
   in unlines $ solve css
