-- https://algo-method.com/tasks/329
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

-- 縦横Nマスのゲーム盤の左上から右下を目指す
-- コマは右 or 下に進む
-- コマがたどる道筋の全パターンを求める
solve :: Int -> Int
solve n = dp ! (n - 1, n - 1)
  where
    dp = listArray ((0, 0), (n - 1, n - 1)) $ map cal [0 .. ((n * n) - 1)] -- 各マスを1からn^2で表現
    -- スタートのマスに到達するのは1通り。その後右と下に進むのはそれぞれ1通りずつしか選択肢がない
    cal :: Int -> Int
    cal 0 = 1
    cal i = left + upper
      where
        h = i `div` n -- 縦
        w = i `mod` n -- 横
        upper = if h == 0 then 0 else dp ! (h - 1, w)
        left = if w == 0 then 0 else dp ! (h, w - 1)

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
