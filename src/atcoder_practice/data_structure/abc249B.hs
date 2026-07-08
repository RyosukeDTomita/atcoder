-- https://atcoder.jp/contests/abc249/tasks/abc249_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.Char (isLower, isUpper)
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
solve s = if Set.size sSet == length s && any isUpper s && any isLower s then "Yes" else "No"
  where
    sSet = Set.fromList s

-- isUpperChar = fromMaybe False $ find isUpper s
-- isLowerChar = fromMaybe False $ find isLower s

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
