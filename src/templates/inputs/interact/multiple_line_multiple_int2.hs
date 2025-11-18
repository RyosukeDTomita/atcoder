-- 冒頭で行の数が示されている場合の二次元のinput (interact版)
main :: IO ()
main = interact $ \input ->
  let ls = lines input -- lsで一旦全体を受け取る
      [h, _] = map read . words $ head ls
      intList2D = map (map read . words) . take h $ tail ls :: [[Int]]
   in unlines . map (unwords . map show) $ intList2D
