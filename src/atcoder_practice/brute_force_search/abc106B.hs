-- https://atcoder.jp/contests/abc106/tasks/abc106_b
-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- nの約数の個数をもとめる
divisorCount :: Int -> Int
divisorCount n = length $ filter (\d -> n `mod` d == 0) [1 .. n]

solve :: Int -> Int
solve n = length $ filter (\x -> divisorCount x == 8) [1, 3 .. n] -- [1, 3 ..]で奇数の連続数列が作れる

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
