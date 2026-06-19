-- https://atcoder.jp/contests/abc273/tasks/abc273_a
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
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

solve :: Int -> Int
solve 0 = 1
solve n = product [1 .. n]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
