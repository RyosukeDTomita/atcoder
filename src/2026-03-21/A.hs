-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (intercalate)

solve :: Int -> String
solve n = intercalate "," . (map show) $ reverse [1 .. n]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> (++ "\n")
