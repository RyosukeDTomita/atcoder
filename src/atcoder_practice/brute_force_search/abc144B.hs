-- https://atcoder.jp/contests/abc144/tasks/abc144_b
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
solve !n =
  let possible =
        [ (a, b)
        | a <- [1 .. 9],
          b <- [1 .. 9],
          a * b == n
        ]
   in if length possible == 0 then "No" else "Yes"

main :: IO ()
main = interact (solve . read)
