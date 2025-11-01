main :: IO ()
main = do
  -- 文字列型での表現に変換
  putStrLn (show True)
  -- 文字列型からの変換を試す
  let array = read "[1, 2, 3]" :: [Int]
  print array