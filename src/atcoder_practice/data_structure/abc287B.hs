-- https://atcoder.jp/contests/abc287/tasks/abc287_b
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

solve :: [String] -> [String] -> Int
solve ss ts = length $ filter (`S.member` tsSet) $ map (drop 3) ss
  where
    tsSet = S.fromList ts

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int]
        !ss = take n $ tail ls :: [String]
        ts = drop (n + 1) ls :: [String]
     in show (solve ss ts) ++ "\n"
