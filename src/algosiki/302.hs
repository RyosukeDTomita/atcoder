-- https://algo-method.com/tasks/302
-- 1ケースWAになった。どうやらNがでかいとIntだとオーバフローしているらしい。
-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [n, x, y] =
  let fibs = x : y : zipWith (+) fibs (tail fibs)
      aPrevN = fibs !! (n - 1)
   in aPrevN `mod` 100

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
