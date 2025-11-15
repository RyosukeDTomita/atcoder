main :: IO ()
main = interact $ \input ->
  -- 2次元配列 [[Int]]
  let intList2D = map (map read . words) . lines $ input :: [[Int]]
   in -- tmp = lines input -- ["1 2 3","4 5 6","7 8 9"]
      show intList2D ++ "\n"
