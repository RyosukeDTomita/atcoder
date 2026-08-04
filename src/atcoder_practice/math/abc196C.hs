-- https://atcoder.jp/contests/abc196/tasks/abc196_c
-- TLEした
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

solve :: Int -> Int
solve n = length [
  i
  | i <- [11..n],
  let iStr = show i,
  let lenI = length iStr,
  -- even lenI && (\(left, right) -> left == right) (splitAt (lenI `div` 2) iStr)
  even lenI && uncurry (==) (splitAt (lenI `div` 2) iStr)
  ]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
