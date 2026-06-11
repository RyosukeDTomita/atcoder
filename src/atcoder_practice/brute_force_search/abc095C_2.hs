-- https://atcoder.jp/contests/abc095/tasks/arc096_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
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

-- | A: ピザAの値段
-- B: ピザBの値段
-- C: ハーフアンドハーフの値段
-- X: ピザAの必要枚数
-- Y: ピザBの必要枚数
--
-- ABピザは2枚買ってAピザ1枚+Bピザ1枚に組み替えるときだけ意味がある(奇数枚は半端が出るだけ)。
-- そこで「ABピザ2枚のペアをk組買う」のkを0..max X Yで全探索し、足りない分を単品で買い足す。O(max(X,Y))。
solve :: [Int] -> Int
solve [a, b, c, x, y] = minimum (map cost [0 .. max x y])
  where
    cost :: Int -> Int
    cost k = 2 * c * k + a * max (x - k) 0 + b * max (y - k) 0

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
