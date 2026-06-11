{-# LANGUAGE BangPatterns #-}
-- https://atcoder.jp/contests/abc057/tasks/abc057_c
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: Int -> Int
solve n = f lowerDivisor (n `div` lowerDivisor)
  where
    lowerDivisor = maximum $ filter (\x -> n `mod` x == 0) [1 .. (floor $ sqrt (fromIntegral n :: Double))] -- 素因数分解した時に小さい側の約数で最大のものを探す。
    f :: Int -> Int -> Int
    f a b = length . show $ max a b -- つねにa <= bなのでmaxいらんかった

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
