-- 終了文字列が存在する場合の2次元input (interact版)
main :: IO ()
main = interact $ \input ->
  let intList2D = map (map read . words) . lines $ input :: [[Int]]
      -- すべてが0の行が出現するまで取得
      result = takeWhile (not . all (== 0)) intList2D
   in show result ++ "\n"
