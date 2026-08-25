-- https://algo-method.com/tasks/325
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

-- 各マスは左上+右上+真上を100で割ったあまり
solve :: Int -> [Int] -> Int
solve n as = grid ! (n - 1, n - 1)
  where
    -- 左上を0、右下をn^2 - 1でiを採番
    -- 構築時に全要素を作ろうとすると無限ループになるので遅延評価が嬉しい例。
    grid = listArray ((0, 0), (n - 1, n - 1)) $ map cal [0 .. (n ^ (2 :: Int) - 1)]
    cal :: Int -> Int
    cal i
      | h == 0 = as !! i
      | otherwise = (left + right + grid ! (h - 1, w)) `mod` 100
      where
        left = if w == 0 then 0 else grid ! (h - 1, w - 1) -- 左上
        right = if w == (n - 1) then 0 else grid ! (h - 1, w + 1) -- 右上
        h = i `div` n
        w = i `mod` n

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve n as) ++ "\n"
