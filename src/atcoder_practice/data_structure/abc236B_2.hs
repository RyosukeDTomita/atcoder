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

import Data.Bits (xor)
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

-- xor版で速度改善 796 ms -> 338 ms
-- xorはbitが違えば1、同じなら0を返す計算で交換・結合法則が成り立つのでカードの順番は気にしなくてよく、4枚揃っている柄のカードは打ち消しあって0になる。
-- また、単位元(0)に対するxorは何も変えないので3枚になっているカードだけが残る
-- 同じ数は0
-- ghci> xor 1 1
-- 0
-- 単位元に対するxor
-- ghci> xor 0 3
-- 3
-- ghci> xor 3 5
-- 6
-- ghci> foldl' xor 0 [1,1,2,3,3]
-- 2
solve :: [Int] -> Int
solve as = foldl' xor 0 as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
