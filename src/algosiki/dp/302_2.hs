-- https://algo-method.com/tasks/302
-- オーバーフローを回避するために足し算するまえに`mod`する
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- 問題のゴールは?: N個の数字as(a0=x,a1=y)で以降は前２つの数字を足して100で割ったあまりと等しいのうち、a_n-1を求める。
solve :: [Int] -> Int
solve [n, x, y] =
  let as = x : y : zipWith (\a b -> (a + b) `mod` 100) as (tail as) -- 遅延評価の共有により、asとtail asで同じ計算をせずにすむ。
   in as !! (n - 1)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
