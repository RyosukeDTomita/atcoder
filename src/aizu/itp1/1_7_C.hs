import Control.Arrow ((>>>))
import Data.List (transpose)

solve :: [[Int]] -> [[Int]]
solve matrix = (verticalSum . horizontalSum) matrix

-- 横方向の合計
horizontalSum :: [[Int]] -> [[Int]]
horizontalSum matrix = map (\row -> row ++ [sum row]) matrix

-- 縦方向の合計をもとめる
verticalSum :: [[Int]] -> [[Int]]
verticalSum matrix = (transpose . map (\col -> col ++ [sum col]) . transpose) matrix -- 一度転置することで、縦方向の合計を求めやすくし、その後もとに戻すz

main :: IO ()
main = interact $ \input ->
  let ls = lines input
      matrix = map (map read . words) $ tail ls :: [[Int]]
   in (solve >>> map (map show >>> unwords) >>> unlines) matrix

-- in unlines . map (unwords . map show) $ solve matrix
