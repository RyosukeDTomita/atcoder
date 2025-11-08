-- 数字に3が含まれているかチェック
includes3 :: Int -> Bool
includes3 0 = False
includes3 x = (x `mod` 10 == 3) || includes3 (x `div` 10) -- 再帰で実装するとどこがでTrueになった場合にそれが最初の呼び出し元まで伝搬される。

main :: IO ()
main = do
  n <- readLn :: IO Int
  let result = filter (\x -> (x `mod` 3 == 0) || includes3 x) [1 .. n]
  putStrLn $ " " ++ unwords (map show result) -- 先頭にスペースが必要