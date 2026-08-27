-- https://algo-method.com/tasks/334
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

-- 縦横Nマスのゲーム盤の左上から右下を目指す
-- コマは右 or 下に進む
-- 各コマにはAijの重みがついている
-- 右下につくまでの重みの合計の最大値を求める
solve :: Int -> [[Int]] -> Int
solve n ass = dp ! (n - 1, n - 1)
  where
    a00 = (head . head) ass
    grid = listArray ((0, 0), (n - 1, n - 1)) $ concat ass
    dp = listArray ((0, 0), (n - 1, n - 1)) $ map cal [0 .. ((n * n) - 1)] -- 各マスを0からn^2-1で表現
    -- スタートのマスに到達するのは1通りでそのコストはa00。
    -- あるマスに到達するための経路のコストは直前のマスまでのコストの合計の大きい方+そのマスのコスト
    cal :: Int -> Int
    cal 0 = a00
    cal i = max left upper + grid ! (h, w)
      where
        h = i `div` n -- 縦
        w = i `mod` n -- 横
        upper = if h == 0 then 0 else dp ! (h - 1, w)
        left = if w == 0 then 0 else dp ! (h, w - 1)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      ass = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n ass) ++ "\n"
