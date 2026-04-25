-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> String
solve [a, b, c] = if a /= b && b == c then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")
