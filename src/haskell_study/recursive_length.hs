-- lengthを再帰で実装する
length' :: [a] -> Int
length' [] = 0
length' (x : xs) = 1 + length' xs

main :: IO ()
main = do
  print $ length' [1, 2, 3]