{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (group, sort)

-- 紙に残る数字 = 出現回数が奇数の値。ソートして連続同値をまとめ、長さが奇数の組を数える
solve :: [Int] -> Int
solve as = length $ filter (odd . length) $ group $ sort as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        as = map read $ tail ls :: [Int]
     in show (solve as) ++ "\n"
