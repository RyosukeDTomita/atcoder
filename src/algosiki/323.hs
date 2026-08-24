-- https://algo-method.com/tasks/323
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

solve :: Int -> [Int] -> String
solve n ds = if reach ! n then "Yes" else "No"
  where
    reach = listArray (0, n) (map f [0 .. n])
    f :: Int -> Bool
    f 0 = True
    f i = or [reach ! (i - d) | d <- ds, d <= i] -- orは[]だとFalse

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int] -- [マスの数, サイコロの種類
        ds = map read . words $ ls !! 1 :: [Int] -- ダイスの目
     in (solve n ds) ++ "\n"
