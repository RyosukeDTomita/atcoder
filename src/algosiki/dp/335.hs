-- https://algo-method.com/tasks/335
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

-- 縦横Nマスのゲーム盤の右上から左下を目指す
-- コマは左 or 下に進む
-- 各コマにはAijの重みがついている
-- 左下につくまでの重みの合計の最小値を求める
solve :: Int -> [[Int]] -> Int
solve n ass = dp ! (n - 1, 0)
  where
    -- !start = dbgId $ (last . head) ass
    start = (last . head) ass
    grid = listArray ((0, 0), (n - 1, n - 1)) $ concat ass
    dp = listArray ((0, 0), (n - 1, n - 1)) $ map cal [0 .. ((n * n) - 1)] -- 各マスを0からn^2-1で表現
    -- スタートのマスに到達するのは1通りでそのコストはa00。
    -- あるマスに到達するための経路のコストは直前のマスまでのコストの合計の小さい方+そのマスのコスト
    inf = maxBound `div` 2 :: Int -- minの加算でオーバーフローしないために半分にする
    cal :: Int -> Int
    cal i
      | i == (n - 1) = start
      | otherwise = min right upper + grid ! (h, w)
      where
        h = i `div` n -- 縦
        w = i `mod` n -- 横
        upper = if h == 0 then inf else dp ! (h - 1, w) -- 番外のコストが無限であるべき。minで選択されないように
        right = if w == (n - 1) then inf else dp ! (h, w + 1)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      ass = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n ass) ++ "\n"
