-- https://algo-method.com/tasks/303
-- WAになった
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

-- 問題のゴールは?: マス0からマスN-1のマスに到達する最短秒数を求める。
-- どんな操作をするか?: 各マスごとに経路1と経路2を使って移動した結果を比べて良い方をとる
-- その操作をすると何が起きるか?: 2マス進む or 1マス進むので現在いるマスの管理が必要。あと進んだ秒数も
-- 最終的に満たすべき条件は?: N-1に到達する(終了条件としてN-1を超えないようにしないといけない)
solve :: Int -> [Int] -> Int
solve n as = go (0, 0)
  where
    arr = listArray (0, n - 1) as
    -- (現在のマス, かかった時間) -> 最終的にかかった時間
    go :: (Int, Int) -> Int
    -- 　現在のマスをxとした時にマスi+2に移動するコストはa_i+1 + a_i or 2 * a_iでどっちがお得か決める
    go (x, !result)
      | x == n - 1 = result
      | x == n - 2 = result + arr ! (n - 1)
      -- WARN: 1マス進んだ先から2マスまとめてすすむ経路が考慮されていない。
      | arr ! (x + 1) + arr ! (x + 2) > 2 * (arr ! (x + 2)) = go (x + 2, result + 2 * (arr ! (x + 2)))
      | otherwise = go (x + 1, result + arr ! (x + 1))

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = read $ head ls :: Int
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve n as) ++ "\n"
