-- https://atcoder.jp/contests/abc122/tasks/abc122_b
-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (foldl')

solve :: String -> Int
solve s = length $ fst $ foldl' go ("", "") s
  where
    go :: (String, String) -> Char -> (String, String)
    go (acc, prev) c
      -- 前回の文字列がATCD or コンボ0なら追加
      | c `elem` "ACGT" && (prev == "" || head prev `elem` "ACTG") = if length acc <= length prev then (c : prev, c : prev) else (acc, c : prev) -- 連結コストを削減するために逆順で保存している
      | otherwise = (acc, "") -- 違う文字列が来たらコンボリセット

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")
