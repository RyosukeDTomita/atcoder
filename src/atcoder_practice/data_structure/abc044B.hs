-- https://atcoder.jp/contests/abc044/submissions/me
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (foldl')
import Data.Map qualified as Map
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
solve w = (output . isBeautiful) frequency
  where
    w' = init w
    frequency = foldl' (\acc c -> Map.insertWith (+) c 1 acc) Map.empty w'
    isBeautiful :: Map.Map Char Int -> Bool
    isBeautiful m = all (even . snd) $ Map.toList m
    output :: Bool -> String
    output result = if result then "Yes" else "No"

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
