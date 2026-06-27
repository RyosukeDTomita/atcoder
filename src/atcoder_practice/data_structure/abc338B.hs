-- https://atcoder.jp/contests/abc338/tasks/abc338_b
{-# LANGUAGE BangPatterns #-}
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

solve :: String -> Char
solve s = fst $ foldl1 (\a b -> if snd b > snd a then b else a) $ Map.toList frequency
  where
    frequency :: Map.Map Char Int
    frequency = foldl' (\acc c -> Map.insertWith (+) c 1 acc) Map.empty s

main :: IO ()
main =
  interact $
    lines >>> head >>> solve >>> (: []) >>> (++ "\n")
