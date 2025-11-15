isPass :: [Int] -> String
isPass [m, f, r]
  | m == -1 || f == -1 = "F"
  | m + f >= 80 = "A"
  | m + f >= 65 = "B"
  | m + f >= 50 = "C"
  | m + f >= 30 && r >= 50 = "C"
  | m + f >= 30 && r < 50 = "D"
  | otherwise = "F"

main :: IO ()
main = interact $ \input ->
  let intList2D = map (map read . words) . lines $ input :: [[Int]]
      -- すべてが0の行が出現するまで取得
      testResults = takeWhile (not . all (== -1)) intList2D
      results = map isPass testResults
   in unlines results
