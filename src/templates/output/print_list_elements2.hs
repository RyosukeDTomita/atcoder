main :: IO ()
main = do
  let xarray = ["Alice", "Taro", "Hoge"]
  mapM_ (\(i, x) -> putStrLn $ "No " ++ show i ++ ": " ++ show x) (zip [1 ..] xarray) -- zipを使ってCase: iの出力に使うリストのインデックスを取得している。