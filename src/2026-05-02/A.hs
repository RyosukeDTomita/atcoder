-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: Int -> String
solve x =
  let possible =
        [ (a, b, c)
          | a <- [1 .. 6],
            b <- [1 .. 6],
            c <- [1 .. 6],
            a + b + c == x
        ]
   in if null possible then "No" else "Yes"

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> (++ "\n")
