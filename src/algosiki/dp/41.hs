-- https://algo-method.com/tasks/41
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

-- 仕事が3種類あり、n日目に実施したときの報酬がasに格納されている。
-- 最大の報酬を受け取る経路を探す問題
-- 過去に選択した仕事を再度受けられない -> 過去の操作が現在の選択に影響する。
-- 解答方針
-- dp [i][j] = i日目に仕事jをやったときのi日目までの報酬の最大値
solve :: [[Int]] -> Int
solve ass = maximum $ foldl' go [0, 0, 0] ass
  where
    -- 前日に選んだ仕事ごとの最大報酬のリストprevから、当日の仕事別最大報酬を作る
    go :: [Int] -> [Int] -> [Int]
    go prev as =
      [ a + maximum [p | (k, p) <- zip [0 :: Int ..] prev, k /= j] -- k /= jで仕事のindexにより同じ仕事を選べないようにしている。
      | (j, a) <- zip [0 ..] as -- 仕事をaとそのindex
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      ass = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve ass) ++ "\n"
