-- 終了文字列が存在する場合の2次元input
main :: IO ()
main = do
  intList2D <- map (map read . words) . lines <$> getContents :: IO [[Int]]
  -- すべてが0の行が出現するまで取得
  let result = takeWhile (not . all (== 0)) intList2D
  print result
