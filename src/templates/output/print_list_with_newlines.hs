main :: IO ()
main = do
  let xs = [1, 2, 3]
  mapM_ (\x -> putStrLn (show x) >> putStrLn "") xs -- リストの要素1つごとに改行を入れて出力