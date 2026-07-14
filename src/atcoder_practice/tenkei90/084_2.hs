-- https://atcoder.jp/contests/typical90/submissions/me
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Data.List (group)

-- 「o,x両方を含む区間数」= 全区間数 - 単色区間数
-- 同じ文字が連続するrun(長さk)は単色区間をk(k+1)/2個持つ
solve :: Int -> String -> Int
solve n s = total - monochrome
  where
    total = n * (n + 1) `div` 2 -- 全区間数
    monochrome = sum [k * (k + 1) `div` 2 | g <- group s, let k = length g] -- 単色区間数

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in show (solve n s) ++ "\n"
