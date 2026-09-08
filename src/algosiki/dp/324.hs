-- https://algo-method.com/tasks/324
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

import Control.Arrow ((>>>))
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

-- 各マスは左上+右上+真上
solve :: [Int] -> Int
solve as@[a0, a1, a2, a3] = grid ! (3, 3)
  where
    -- 左上を0、右下を15でiを採番
    grid = listArray ((0, 0), (3, 3)) $ map cal [0 .. 15]
    cal :: Int -> Int
    cal i
      | h == 0 = as !! i
      | otherwise = left + right + grid ! (h - 1, w)
      where
        left = if w == 0 then 0 else grid ! (h - 1, w - 1) -- 左上
        right = if w == 3 then 0 else grid ! (h - 1, w + 1) -- 右上
        h = i `div` 4
        w = i `mod` 4

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
