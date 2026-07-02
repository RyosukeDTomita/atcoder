-- https://atcoder.jp/contests/abc071/tasks/abc071_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
-- import Data.List (foldl')
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

solve :: String -> String
solve s = if null result then "None" else result
  where
    result = foldr (\c acc -> if c `Set.notMember` sSet then [c] else acc) "None" ['a' .. 'z'] -- ['a'..]だと全アスキーになってしまう
    sSet = Set.fromList $ init s

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
