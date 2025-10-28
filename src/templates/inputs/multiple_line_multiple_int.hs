main :: IO ()
main = do
  -- 2次元配列 [[Int]]
  intList2D <- map (map read . words) . lines <$> getContents :: IO [[Int]]
  -- tmp <- lines <$> getContents -- ["1 2 3","4 5 6","7 8 9"]
  -- print tmp
  print intList2D
