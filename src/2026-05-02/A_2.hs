-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

-- 3つのサイコロで表現できる数は3から18
solve :: Int -> String
solve x = if x `elem` [3 .. 18] then "Yes" else "No"

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> (++ "\n")
