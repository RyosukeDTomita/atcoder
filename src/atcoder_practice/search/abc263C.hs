-- https://atcoder.jp/contests/abc263/tasks/abc263_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (sort, subsequences)
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

solve :: [Int] -> [[Int]]
solve [n, m] = sort $ filter (\xs -> length xs == n) $ subsequences [1 .. m]

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> map (map show >>> unwords) >>> unlines
