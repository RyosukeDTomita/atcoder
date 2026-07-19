-- https://atcoder.jp/contests/abc467/submissions/77653754
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.ByteString.Char8 qualified as BS
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- m=2固定の場合
-- b_i == 0 -> (a_i + a_(i+1)) `mod` 2 == 0
-- b_i == 1 -> (a_i + a_(i+1)) `mod` 2 == 1
-- 配列の破壊的変更をせずに、再帰で解く。そのために、iのとき、i+1の要素を状態として持つ
-- A_1に足すか否か(x1=0/1)で残りの反転はすべて一意に決まるので、
-- 貪欲を2回(x1=0とx1=1)走らせてminを取る。
solve :: [Int] -> [Int] -> Int
solve aList@(a0: aRest) bList = min (go a0 aRest bList 0) (go (a0 + 1) aRest bList 0 + 1) -- 2回目の貪欲法はa0に+1した状態から始めるので1回分cntを増やしている
  where
    go :: Int -> [Int] -> [Int] -> Int -> Int
    go _ [] [] cnt = cnt
    go ai (ai': as) (bi : bs) !cnt -- ai'=a_(i+1) cntをBangPatternにしてみたが、実行時間は変わらず(GHCが賢い)
      | (ai + ai') `mod` 2 == bi = go ai' as bs cnt
      | otherwise = go (ai' + 1) as bs (cnt + 1)


main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      -- [n, _m] = map readInt . BS.words $ head ls :: [Int] -- m=2
      aList = map readInt . BS.words $ ls !! 1 :: [Int]
      bList = map readInt . BS.words $ ls !! 2 :: [Int]
   in (BS.pack . show) (solve aList bList) <> BS.pack "\n"
