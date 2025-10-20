-- mapを自分で実装してみる
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs -- 先頭要素に引数で渡された関数を渡して連結する

main :: IO ()
main = do
  print $ map show [1, 2, 3, 4, 5]
  print $ map' show [1, 2, 3, 4, 5]