-- https://atcoder.jp/contests/abc248/tasks/abc248_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.Char (digitToInt)
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

solve :: String -> Int
solve s =
  head
    [ digitToInt c
    | c <- candidates,
      c `notElem` s
    ]
  where
    candidates = concatMap show [0 .. 9]

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")
