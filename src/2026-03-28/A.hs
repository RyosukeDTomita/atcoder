{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# LANGUAGE BangPatterns #-}
import Control.Arrow ((>>>))

solve :: String -> String
solve s =
  let s' = filter (/= '\n') s
   in if (length s') `mod` 5 == 0 then "Yes" else "No"

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
