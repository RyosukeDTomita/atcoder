-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
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

-- |
-- A_i: 木こりiが落とした斧
-- B_i: 斧iをを持っていた木こり
solve :: Int -> [Int] -> [Int] -> String
solve n as bs = if result then "Yes" else "No"
  where
    result = foldl' go True $ zip3 as bs [1 .. n]
    go :: Bool -> (Int, Int, Int) -> Bool
    go acc (a, b, i) = acc && (i == bs !! (a - 1))

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
      bs = map read . words $ ls !! 2 :: [Int]
   in (solve n as bs) ++ "\n"
