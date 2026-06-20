-- https://atcoder.jp/contests/abc153/tasks/abc153_d
import Control.Arrow ((>>>))

-- 分裂は経路に依らず一様なので深さk=floor(log2 H)の完全2分木になる。
-- 攻撃回数=ノード総数1+2+2^2+...2^k=等比数列の和=2^(k+1)-1。
solve :: Int -> Int
solve h = 2 ^ (k + 1) - 1
  where
    k :: Int
    k = length $ takeWhile (> 1) $ iterate (`div` 2) h -- 1になるまで半分にする回数

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
