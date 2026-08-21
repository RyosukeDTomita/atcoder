-- https://algo-method.com/tasks/306
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wmissing-local-signatures #-}
{-# OPTIONS_GHC -Wmissing-signatures #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wtype-defaults #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- TLE調査時に有効化する。MRが適用されて単相化された(=共有が効いている)束縛を報告する。
-- {-# OPTIONS_GHC -Wmonomorphism-restriction #-}

import Data.Array
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

-- 問題のゴールは?: マス0からマスN-1に到達する最短秒数を求める。
solve :: Int -> Int -> [Int] -> Int
solve n m as = head $ foldl' go [0] [1 .. n - 1] -- dp[n-1]が答えになるので最後の畳み込み結果の先頭が答え
  where
    arr = listArray (0, n - 1) as
    -- prevsは新しい順[dp[i-1], dp[i-2], ..., dp[i-M]]。
    go :: [Int] -> Int -> [Int]
    go prevs i = take m (next : prevs) -- iがM未満のうちは長さiのまま育つのでkの上限判定(take m)は効いていない。
      where
        -- foldl'はリストのWHNFしか潰さないので、ここでbangを付けないとサンクが積み上がる
        !next = minimum $ zipWith (\k p -> p + k * arr ! i) [1 ..] prevs -- マスiに到達する全経路の最小コスト

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int]
        xs = map read . words $ ls !! 1 :: [Int]
     in show (solve n m xs) ++ "\n"
