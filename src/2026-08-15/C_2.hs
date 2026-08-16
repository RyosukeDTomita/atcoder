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

import Data.List (sort)
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

-- 正と負それぞれのに近い順にしたリストを作り、それぞれの先頭の候補2つを比較して近い方に進む。
solve :: [Int] -> Int
solve as = go (0, 0, nAs', pAs)
  where
    (nAs, pAs) = break (> 0) $ sort as
    -- nAs' = sortOn (Down) nAs
    nAs' = reverse nAs -- 100 msくらい速くなった。上でsortしてあるのを利用する。
    go :: (Int, Int, [Int], [Int]) -> Int
    go (_, !result, [], []) = result
    go (ai, !result, [], (p : pRest)) = go (p, (result + abs (ai - p)), [], pRest)
    go (ai, !result, (n : nRest), []) = go (n, (result + abs (ai - n)), nRest, [])
    go (ai, !result, nList@(n : nRest), pList@(p : pRest)) =
      let nDiff = abs (ai - n)
          pDiff = abs (ai - p)
       in if nDiff <= pDiff then go (n, result + nDiff, nRest, pList) else go (p, result + pDiff, nList, pRest)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
