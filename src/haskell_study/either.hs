main :: IO ()
main = do
  -- Either の基本的な使い方
  let errorResult = Left "Error occurred!" :: Either String Int
  let successResult = Right 200 :: Either String Int

  print errorResult -- Left "Error occurred!"
  print successResult -- Right 200

  -- パターンマッチングで値を取り出す
  case errorResult of
    Left err -> putStrLn $ "エラー: " ++ err -- こっちが出力される
    Right val -> putStrLn $ "成功: " ++ show val

  case successResult of
    Left err -> putStrLn $ "エラー: " ++ err
    Right val -> putStrLn $ "成功: " ++ show val -- こっちが出力される