-- https://atcoder.jp/contests/abc144/tasks/abc144_b
-- ペアを全列挙せず、約数で考える
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

solve :: Int -> String
solve !n = if any (\a -> n `mod` a == 0 && n `div` a <= 9) [1 .. 9] then "Yes" else "No"

main :: IO ()
main = interact (solve . read)
