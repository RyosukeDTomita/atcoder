-- 3x3と3x1の行列の足し算
add :: [[Int]] -> [Int] -> [[Int]]
add matrixA matrixB =
  [ zipWith (+) row matrixB
    | row <- matrixA
  ]

-- 行列の定数倍
mul :: [[Int]] -> Int -> [[Int]]
mul matrixA n =
  [ map (* n) row
    | row <- matrixA
  ]

-- 行列積 3x3と3x1の行列の行列積
matmul :: [[Int]] -> [Int] -> [Int]
matmul matrixA matrixB =
  [ sum $ zipWith (*) row matrixB -- sumで要素ごとの計算結果の和を出している。
    | row <- matrixA
  ]

main :: IO ()
main = do
  let matrixA = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  let matrixB = [10, 11, 12]
  print matrixA
  print matrixB
  -- 足し算
  print $ add matrixA matrixB
  -- 定数倍
  print $ mul matrixA 10
  -- 行列積
  print $ matmul matrixA matrixB