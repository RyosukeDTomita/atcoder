main :: IO ()
main = interact $ \input ->
  -- 2次元配列 [[Int]]
  let intList2D = map (map read . words) . lines $ input :: [[Int]]
   in unlines . map (unwords . map show) $ intList2D
