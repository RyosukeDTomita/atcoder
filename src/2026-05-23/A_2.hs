-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: Int -> String
solve x =
  [ c
  | (i, c) <- zip [1 ..] "HelloWorld",
    i /= x
  ]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> (++ "\n")
