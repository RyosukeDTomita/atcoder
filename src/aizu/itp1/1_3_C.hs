import Data.List (intercalate, sort)

main :: IO ()
main = do
  -- 縦列の入力を取得し、各行ごとにソートする
  -- 1 2
  -- 3 2
  -- 3 4
  -- 0 0
  intList2D <- map (sort . map read . words) . lines <$> getContents :: IO [[Int]]
  -- すべてが0の行が出現するまで取得
  let result = takeWhile (not . all (== 0)) intList2D
  mapM_ (putStrLn . unwords . map show) result -- unwordsでスペース区切りに戻す
  -- mapM_ (print . map show) result -- ["1","2"]\n["2","3"]\n["3","4"]
