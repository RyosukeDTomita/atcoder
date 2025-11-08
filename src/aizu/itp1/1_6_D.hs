import Control.Monad (replicateM)

solve :: [[Int]] -> [Int] -> [Int]
solve matrixA vectorB =
  [ sum $ zipWith (*) row vectorB
    | row <- matrixA
  ]

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine :: IO [Int]
  matrixA <- replicateM n $ map read . words <$> getLine :: IO [[Int]]
  matrixb <- replicateM m readLn :: IO [Int]
  -- print matrixA
  -- print matrixb
  putStr $ unlines $ (map show) (solve matrixA matrixb)