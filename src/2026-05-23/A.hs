-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: Int -> String
solve x =
  let (left, right) = splitAt (x - 1) "HelloWorld"
   in left ++ tail right

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> (++ "\n")
