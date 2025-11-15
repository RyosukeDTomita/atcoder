main :: IO ()
main = do
  numbers <- map read . lines <$> getContents :: IO [Int]
  let intList = takeWhile (/= 0) numbers -- 終了文字列0までnumbersから値を取得する
  print intList
