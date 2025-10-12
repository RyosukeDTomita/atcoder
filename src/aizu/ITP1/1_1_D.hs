toHMS :: Int -> String
toHMS s =
  -- 複数行になるletはインデントでまとめて書ける
  let h = s `div` 3600
      m = (s `mod` 3600) `div` 60
      sec = s `mod` 60
   in show h ++ ":" ++ show m ++ ":" ++ show sec -- 定義した変数を使うためにinが必要。最後に評価される式が戻り値になる

main :: IO ()
main = do
  s <- readLn :: IO Int
  putStrLn (toHMS s)