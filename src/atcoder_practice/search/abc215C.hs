-- https://atcoder.jp/contests/abc215/tasks/abc215_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (permutations)
import Data.Set qualified as Set
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

solve :: [String] -> String
solve [s, kStr] = Set.elemAt (k - 1) permSet
  where
    k = read kStr :: Int
    permSet = Set.fromList $ permutations s -- Setで重複を削除

main :: IO ()
main =
  interact $
    words >>> solve >>> (++ "\n")
