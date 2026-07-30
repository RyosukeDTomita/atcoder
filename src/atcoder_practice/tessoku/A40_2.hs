-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_an
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
{-# LANGUAGE MonoLocalBinds #-}
import Data.Array (accumArray, elems)

nCr :: Int -> Int -> Int
nCr n r = product [n - r + 1 .. n] `div` product [1 .. r]

-- Mapは挿入にO(log n)かかるがaccumArrayならO(1)
solve :: [Int] -> Int
solve as = sum [nCr c 3 | c <- elems freq, c >= 3]
  where
    freq = accumArray (+) 0 (1, 100) [(a, 1) | a <- as]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
