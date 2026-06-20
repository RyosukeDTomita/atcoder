-- https://atcoder.jp/contests/abc247/tasks/abc247_c
{-# LANGUAGE BangPatterns #-}
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

solve :: Int -> [Int]
solve n = go n
  where
    go :: Int -> [Int]
    go 1 = [1]
    go n =
      let snm1 = go (n - 1)
       in snm1 ++ [n] ++ snm1

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map show >>> unwords >>> (++ "\n")
