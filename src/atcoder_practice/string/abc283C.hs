-- https://atcoder.jp/contests/abc283/tasks/abc283_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (foldl', group)
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}

debug :: Bool
debug = True

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- どんな操作をするか?: 先頭から文字列を1文字ずつ読み取り、対応するボタンを押す。完全にStringでかけそう
-- 操作をすると何が起きるか? 文字列の末尾に該当の文字が追加される。
-- 最終的に満たすべき条件は?: 00の数がわかれば良いだけ
solve :: String -> Int
solve s = length s' - foldl' (\acc x -> if head x == '0' then acc + ((length x) `div` 2) else acc) 0 rle
  where
    rle = group s
    s' = dbgId $ init s -- 改行を消す。

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")
