-- https://algo-method.com/tasks/305
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

-- 縦幅1、横幅nの壁にタイルを貼る
-- タイルの種類は横幅1、2、3がある
-- 304とほぼ同じ形で解けるはず
solve :: Int -> Int
solve n = arr ! n
  where
    arr = listArray (0, n) $ map pattern [0 .. n]
    pattern :: Int -> Int
    pattern 0 = 0
    pattern 1 = 1
    pattern 2 = 2
    pattern 3 = 4 -- 111 12 21 3
    pattern i = arr ! (i - 3) + arr ! (i - 2) + arr ! (i - 1)

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
