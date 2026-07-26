-- https://atcoder.jp/contests/abc468/submissions/77839861
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (permutations)
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

-- C_2のように数え上げずに、素直にやってもいけるらしい。
-- sortするとストリーミングで繋がらなくなるのでsortせずにpermutationsのうち、P、Qの間にあるものだけ数え上げる。
solve :: Int -> [Int] -> [Int] -> Int
solve n ps qs =
  length $
    [ p
    | p <- perm,
      p > ps,
      p < qs
    ]
  where
    perm = permutations [1 .. n]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ps = map read . words $ ls !! 1 :: [Int]
        qs = map read . words $ ls !! 2 :: [Int]
     in show (solve n ps qs) ++ "\n"
