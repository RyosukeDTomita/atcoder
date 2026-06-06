{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# LANGUAGE BangPatterns #-}
import Control.Arrow ((>>>))

solve :: [Int] -> String
solve [a, d] = if d >= a then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")
