-- https://atcoder.jp/contests/abc465/tasks/abc465_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
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

-- A, BとL, Rの重なる部分がoverlap
-- l r
solve :: [Int] -> Int
solve [x, y, l, r, a, b]　= overlap * x + (b - a - overlap) * y
  where
    overlap = max 0 (min b r - max a l)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
