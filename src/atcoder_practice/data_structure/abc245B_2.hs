-- https://atcoder.jp/contests/abc245/tasks/abc245_b
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.IntSet qualified as IntSet
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
solve n as =
  -- 集合化(IntSet)でiの判定をO(log N)に
  let seen = IntSet.fromList as
   in head [i | i <- [0 .. n], not (IntSet.member i seen)]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        !as = map read . words $ ls !! 1 :: [Int]
     in show (solve n as) ++ "\n"
