-- https://atcoder.jp/contests/abc420/tasks/abc420_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl', transpose)
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

-- 1回の投票(長さNの'0'/'1'列)から、その回の得点ベクトル(長さN)を作る。
pointsForRound :: String -> [Int]
pointsForRound col
  | zeros == 0 || ones == 0 = replicate (length col) 1
  | otherwise = map (\c -> if c == minorityBit then 1 else 0) col
  where
    zeros = length $ filter (== '0') col
    ones = length col - zeros
    minorityBit = if zeros < ones then '0' else '1'

solve :: Int -> [String] -> [Int]
solve n ss =
  [ i
  | (i, s) <- zip [1 .. n] scores,
    s == best
  ]
  where
    rounds = map pointsForRound $ transpose ss
    scores = foldl' (zipWith (+)) (replicate n 0) rounds -- mapではだめ。畳み込む必要がある。
    best = maximum scores

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, _m] = map read . words $ head ls :: [Int] -- nは奇数
        ss = tail ls
     in (unwords . map show) (solve n ss) ++ "\n"
