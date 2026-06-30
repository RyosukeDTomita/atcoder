-- https://atcoder.jp/contests/abc153/tasks/abc153_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (sortOn)
import Data.Ord (Down (..))
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

solve :: Int -> [Int] -> Int
solve k hs = (sum . drop k) hs'
  where
    hs' = sortOn Down hs

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, k] = map read . words $ head ls :: [Int]
        hs = map read . words $ ls !! 1 :: [Int]
     in show (solve k hs) ++ "\n"
