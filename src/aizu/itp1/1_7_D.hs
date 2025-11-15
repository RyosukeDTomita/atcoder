import Data.List (transpose)

--- 行列の掛け算
matrixMultiply :: [[Int]] -> [[Int]] -> [[Int]]
matrixMultiply ass bss =
  let cols = transpose bss
   in [ [sum (zipWith (*) row col) | col <- cols]
        | row <- ass
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m, l] = map read . words $ head ls :: [Int]
      ass = map (map read . words) . take n $ tail ls :: [[Int]]
      bss = map (map read . words) . take m . drop n $ tail ls :: [[Int]]
   in unlines . map (unwords . map show) $ matrixMultiply ass bss