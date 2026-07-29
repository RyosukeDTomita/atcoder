-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_ai
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

-- listをArrayにするなら最初からVectorにしてみたが316ms -> 315msで変わらなかった。
solve :: Int -> [Int] -> [[Int]] -> [Int]
solve n as lrs = map (\[l, r] -> prefixSum VU.! r - prefixSum VU.! (l - 1)) lrs
  where
    prefixSum = VU.scanl' (+) 0 $ VU.fromList as

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, q] = map read . words $ head ls :: [Int]
      as = map read . words $ ls !! 1 :: [Int]
      lrs = map (map read . words) $ drop 2 ls :: [[Int]]
   in unlines $ map show $ solve n as lrs
