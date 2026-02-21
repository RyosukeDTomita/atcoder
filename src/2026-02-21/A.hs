{-# LANGUAGE BangPatterns #-}

import Control.Arrow ((>>>))

solve :: Int -> [Int]
solve n = [n]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map show >>> unwords >>> (++ "\n")