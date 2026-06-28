{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
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

-- eastとwest両方数えなくても全体から引けば良かった
solve :: String -> String
solve s = if eastN > westN then "East" else "West"
  where
    eastN = length $ filter (== 'E') s
    westN = length (init s) - eastN

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
