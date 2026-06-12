-- https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_d
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (isSubsequenceOf)
import Debug.Trace (traceShowId)
import Text.Printf (printf)

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

-- sを全通り探すと2^nでTLEになるので逆に暗証番号として取りうる値がsの部分列にあるかを探す
solve :: String -> Int
solve s = length $ filter (`isSubsequenceOf` s) candidates
  where
    candidates = [printf "%03d" i | i <- [0 .. 999 :: Int]] :: [String]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- s = (read :: String -> Int) $ ls !! 1
        s = ls !! 1 -- 文字列にする
     in show (solve s) ++ "\n"
