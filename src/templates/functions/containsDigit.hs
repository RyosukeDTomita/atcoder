-- 数字xにnが含まれているかチェック
includesN :: Int -> Int -> Bool
includesN 0 n = n == 0
includesN x n = (x `mod` 10 == n) || includesN (x `div` 10) n -- 再帰で実装するとどこがでTrueになった場合にそれが最初の呼び出し元まで伝搬される。

main :: IO ()
main = do
  let n = 3
  print $ includesN 103 3 -- True
  print $ includesN 103 4 -- False
  print $ includesN 103 0 -- True