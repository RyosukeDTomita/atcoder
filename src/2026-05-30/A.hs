-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- カーリー化すげえ
solve :: [Int] -> Int
solve [n, m] = length $ takeWhile (/= 0) $ iterate (n `mod`) m

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
