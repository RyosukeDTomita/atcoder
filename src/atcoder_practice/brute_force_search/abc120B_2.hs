-- https://atcoder.jp/contests/abc120/tasks/abc120_b
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [a, b, k] = commonDivisors !! (k - 1)
  where
    gcd' = gcd a b
    -- 公約数を降順に生成(gcd'の約数 = A,Bの公約数)
    commonDivisors = filter (\x -> gcd' `mod` x == 0) [gcd', gcd' - 1 .. 1] -- reverseしなくてすむように逆順で1からgcc'までの数列を与えている。

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
