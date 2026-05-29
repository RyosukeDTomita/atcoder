-- https://atcoder.jp/contests/abc342/tasks/abc342_c
-- abc342C.hs の ByteString + Vector 高速化版。アルゴリズムは同一。
{-# LANGUAGE BangPatterns #-}

import Data.ByteString.Char8 qualified as BS
import Data.Char (ord)
import Data.List (foldl')
import Data.Vector.Unboxed qualified as VU

-- 各英小文字 'a'..'z' の現在の置き換え先を長さ26のテーブルで持つ。
-- 操作 (c, d) はテーブル中の c をすべて d に書き換えるだけでよい
-- (文字 x が現在 c になっているなら、その x も d に置き換わる)。
-- テーブルは長さ26の Unboxed Vector で保持し、各操作で VU.map により更新する。
-- リスト版 (foldl' + list map) だと map のサンキが Q 段積み上がり、
-- 5M 個の遅延クロージャ確保と GC で激遅になる。Unboxed Vector は map が正格に
-- 26要素のフラット配列を作るので、サンキの蓄積なく高速。
solve :: BS.ByteString -> [(Char, Char)] -> BS.ByteString
solve s ops =
  let replace :: VU.Vector Char -> (Char, Char) -> VU.Vector Char
      replace tbl (c, d) = VU.map (\x -> if x == c then d else x) tbl
      !table = foldl' replace (VU.fromList ['a' .. 'z']) ops -- 最終的な置き換え先
      lookupChar :: Char -> Char
      lookupChar ch = table `VU.unsafeIndex` (ord ch - ord 'a')
   in BS.map lookupChar s

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      s = ls !! 1
      toOp :: BS.ByteString -> (Char, Char)
      toOp l = let [c, d] = BS.words l in (BS.head c, BS.head d)
      ops = map toOp (drop 3 ls)
   in solve s ops `BS.snoc` '\n'
