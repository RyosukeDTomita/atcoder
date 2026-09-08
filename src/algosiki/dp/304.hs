-- https://algo-method.com/tasks/304
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

-- n段ある階段を登り切るパターンを求める問題
-- bit全探索するとTLEする
-- n段ある階段のうち、i番目に到達する経路を求めれば良さそう
solve :: Int -> Int
solve n = arr ! n
  where
    arr = listArray (0, n) $ map pattern [0 .. n]
    pattern :: Int -> Int
    pattern 0 = 0
    pattern 1 = 1
    pattern 2 = 2
    pattern i = arr ! (i - 2) + arr ! (i - 1)

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
