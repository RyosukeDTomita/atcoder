-- https://algo-method.com/tasks/303
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

-- 問題のゴールは?: マス0からマスN-1のマスに到達する最短秒数を求める。
-- どんな操作をするか?: マスiへの到達コストdp[i]を小さい添字から順に確定させる
-- その操作をすると何が起きるか?: マスiへは「i-1から1マス(a_i)」か「i-2から2マス(2*a_i)」でしか来ないので、そのminをとればよい
-- 最終的に満たすべき条件は?: dp[N-1]が答え
solve :: Int -> [Int] -> Int
solve n as = snd $ foldl' go (0, arr ! 1) [2 .. n - 1]
  where
    arr = listArray (0, n - 1) as
    -- 自分のマスを動かすのではなく、各マスに到達するための最小値をもとめる方針にする
    -- そのためにiに到達できるのはdp[i-2] + 2 * a_iとdp[i-1] + a_iの最小値である。
    -- dpは再帰的に計算される。
    go :: (Int, Int) -> Int -> (Int, Int)
    go (!prev2, !prev1) i = (prev1, min (prev1 + arr ! i) (prev2 + 2 * (arr ! i)))

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = read $ head ls :: Int
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve n as) ++ "\n"
