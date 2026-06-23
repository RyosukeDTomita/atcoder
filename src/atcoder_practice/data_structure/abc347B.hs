-- https://atcoder.jp/contests/abc347/tasks/abc347_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (inits, tails)
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

-- 全接尾辞(tails)それぞれの空でない接頭辞(tail.inits)を集めると全部分文字列になる
-- ghci> tails "abc"
-- ["abc","bc","c",""]
-- ghci> map inits $ tails "abc"
-- [["","a","ab","abc"],["","b","bc"],["","c"],[""]]
-- ghci> map (tail . inits) $ tails "abc"
-- [["a","ab","abc"],["b","bc"],["c"],[]]
-- ghci> concatMap (tail . inits) $ tails "abc"
-- ["a","ab","abc","b","bc","c"]
substrings :: String -> [String]
substrings s = concatMap (tail . inits) $ tails s

solve :: String -> Int
solve s = Set.size $ Set.fromList $ substrings s

main :: IO ()
main =
  interact $
    head . lines >>> solve >>> show >>> (++ "\n")
