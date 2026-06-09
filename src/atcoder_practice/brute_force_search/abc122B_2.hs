-- https://atcoder.jp/contests/abc122/tasks/abc122_b
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- maskedを使い、関係のない文字列を空白に置き換え、wordsでリストに分解して最大の長さのものを求める。
solve :: String -> Int
solve s = maximum $ 0 : map length (words masked)
  where
    -- ACGT以外を空白に置き換える(空白がwordsの区切りになる)
    masked :: String
    masked = map (\c -> if c `elem` "ACGT" then c else ' ') s

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")
