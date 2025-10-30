main :: IO ()
main = do
  let xarray = ["Alice", "Taro", "Hoge"]
  mapM_ putStrLn xarray -- unwordsで配列をスペース区切りに戻す