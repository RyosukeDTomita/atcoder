-- https://atcoder.jp/contests/abc342/tasks/abc342_c
-- ACできたけど結構ギリギリだった。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Char (ord)
import Data.List (foldl')
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

-- 各英小文字 'a'..'z' の現在の置き換え先を長さ26のテーブルで持つ。
-- 操作 (c, d) はテーブル中の c をすべて d に書き換えるだけでよい
-- (文字 x が現在 c になっているなら、その x も d に置き換わる)。
solve :: String -> [(Char, Char)] -> String
solve s ops =
  let replace (c, d) tbl = map (\x -> if x == c then d else x) tbl
      !table = dbgId $ foldl' (flip replace) ['a' .. 'z'] ops -- tableに最終的な置き換え先が記載される。
   in map (\ch -> table !! (ord ch - ord 'a')) s

-- NOTE: ord 'a'と比較することでアルファベット順で何文字目かわかる。
-- ghci> ord 'a'
-- 97
-- ghci> ord 'c'
-- 99
-- ghci> ord 'c' - ord 'a'
-- 2

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      s = ls !! 1
      ops = map (\l -> let [c, d] = words l in (head c, head d)) (drop 3 ls)
   in solve s ops ++ "\n"
