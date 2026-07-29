-- https://atcoder.jp/contests/awc0075/tasks/awc0075_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
import Data.Vector.Unboxed qualified as VU
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

solve :: Int -> Int -> [Int] -> Int
solve n k as = foldl' go (k * (10 ^ 9)) [0 .. (n - k)]
  where
    prefixSum = dbgId $ VU.scanl' (+) 0 $ VU.fromList as
    go :: Int -> Int -> Int
    go acc i = min acc (prefixSum VU.! (i + k) - prefixSum VU.! i)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, k] = map read . words $ head ls :: [Int]
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve n k as) ++ "\n"
