-- {-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))

solve :: [Int] -> [[Int]]
solve [h, w] =
  [ [ (if i > 1 then 1 else 0)
        + (if i < h then 1 else 0)
        + (if j > 1 then 1 else 0)
        + (if j < w then 1 else 0)
    | j <- [1 .. w]
    ]
  | i <- [1 .. h]
  ]

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines
