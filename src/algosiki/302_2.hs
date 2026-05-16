-- https://algo-method.com/tasks/302
-- オーバーフローを回避するために足し算するまえに`mod`する
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [n, x, y] =
  let as = x : y : zipWith (\a b -> (a + b) `mod` 100) as (tail as)
   in as !! (n - 1)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
