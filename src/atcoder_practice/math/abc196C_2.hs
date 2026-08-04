-- https://atcoder.jp/contests/abc196/tasks/abc196_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
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

solve :: String -> Int
solve nStr
  | odd lenN = 10 ^ half - 1 -- 先頭桁は0であってはいけないが、奇数桁の場合は-1桁から数え上げる
  -- 偶数桁: i < prefixなら必ずn以下。i == prefixのときだけ実際に比較する。
  | doubled <= nStr = prefix
  | otherwise = prefix - 1 -- doubledの分-1
  where
    lenN = length nStr
    half = lenN `div` 2
    -- 掛け算でもとめるべきと思ってたが、偶数の場合は桁の半分の取りうる値すべてが答えになるのか。
    prefixStr = take half nStr
    prefix = read prefixStr
    -- prefixを2回並べた数がn以下の最大数の候補になる。
    doubled = prefixStr ++ prefixStr

main :: IO ()
main =
  interact $
    lines >>> head >>> solve >>> show >>> (++ "\n")
