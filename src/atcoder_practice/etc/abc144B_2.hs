-- https://atcoder.jp/contests/abc144/tasks/abc144_b
-- リストモナドで書き直した
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad (guard)
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
  let possible = do
        a <- [1 .. 9]
        b <- [1 .. 9]
        guard (a * b == n)
        return (a, b)
   in if length possible == 0 then "No" else "Yes"

main :: IO ()
main = interact (solve . read)
