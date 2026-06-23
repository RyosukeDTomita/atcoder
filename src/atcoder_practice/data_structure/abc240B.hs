-- https://atcoder.jp/contests/abc240/tasks/abc240_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Set qualified as S
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

solve :: [Int] -> Int
solve as = S.size $ S.fromList as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        !as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
