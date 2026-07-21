-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_fd
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- 全頂点の次数が2の連結無向グラフ = 1本のサイクル 1-2-...-n-1
-- 辺(i, i mod n + 1)をi<-[1..n]で回すと、i=nのときn mod n + 1 = 1で閉じる
solve :: Int -> [[Int]]
solve n = [n] : [[i, i `mod` n + 1] | i <- [1 .. n]]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines
