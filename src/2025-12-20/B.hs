import Data.List (foldl', maximumBy)

solve :: [[Int]] -> [Int] -> Int
solve ass bs = maximum $ map (\as -> length (findB as bs)) ass

findB :: [Int] -> [Int] -> [Int]
findB _ [] = []
findB as (b : bRest) = filter (== b) as ++ findB as bRest

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [h, w, n] = map read . words $ head ls :: [Int]
      ass = map (map read . words) $ take h $ tail ls :: [[Int]]
      bs = map read $ drop h $ tail ls :: [Int]
   in show (solve ass bs) ++ "\n"