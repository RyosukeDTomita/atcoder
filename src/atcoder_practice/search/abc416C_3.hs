-- https://atcoder.jp/contests/abc416/tasks/abc416_c
-- 添字列ではなく文字列列そのものをreplicateMで列挙し、concatで連結する。
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
{-# LANGUAGE MonoLocalBinds #-}
import Control.Monad (replicateM)
import Data.List (sort)

solve :: Int -> Int -> [String] -> String
solve k x ss = sort (map concat (replicateM k ss)) !! (x - 1)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [_n, k, x] = map read . words $ head ls :: [Int]
        ss = tail ls
     in solve k x ss ++ "\n"
