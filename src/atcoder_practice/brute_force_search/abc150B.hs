-- https://atcoder.jp/contests/abc150/tasks/abc150_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (tails)
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

solve :: String -> Int
solve s = length $ filter ((== "ABC") . take 3) $ tails s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- !n = (read :: String -> Int) $ head ls
        !s = ls !! 1
     in show (solve s) ++ "\n"
