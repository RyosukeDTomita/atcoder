-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> String
solve [m, d] =
  let target = [[1, 7], [3, 3], [5, 5], [7, 7], [9, 9]]
   in if [m, d] `elem` target then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")
