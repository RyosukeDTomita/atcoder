-- https://atcoder.jp/contests/abc374/tasks/abc374_c
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

import Data.Bits (shiftL, testBit)
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

-- 問題のゴールは? 部単位で選択して2つのグループに分けてなるべく同じ数のグループになるようにして大きい方のグループの人数を求める
-- どんな操作をするか?: bit全探索でAグループの取りうる人数をすべて算出する。
-- その操作をすると何が起きるか?:
-- 最終的に満たすべき条件は?:
solve :: [Int] -> Int
solve ks = fst $ foldl' go (0, 100000000) possibleA
  where
    sumKs = sum ks
    possibleA =
      [ [ k
        | (i, k) <- zip [0 ..] ks,
          testBit bit i
        ]
      | bit <- [0 .. (1 `shiftL` n :: Int) - 1]
      ]
    n = length ks
    go :: (Int, Int) -> [Int] -> (Int, Int)
    go acc@(result, diff) a
      | aDiffB < diff = (max sumA sumB, aDiffB)
      | otherwise = acc
      where
        sumA = sum a
        sumB = sum ks - sum a
        aDiffB = abs (sumA - sumB)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ks = map read . words $ ls !! 1 :: [Int]
     in show (solve ks) ++ "\n"
