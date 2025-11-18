-- 終了文字列が存在する場合の2次元input (interact版)
main :: IO ()
main = interact $ \input ->
  let ls = map (map read . words) . lines $ input :: [[Int]]
      -- すべてが0の行が出現するまで取得
      inputList2D = takeWhile (not . all (== 0)) ls
   in unlines . map (unwords . map show) $ inputList2D
