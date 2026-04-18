-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [l, r] = length [l .. r]

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
