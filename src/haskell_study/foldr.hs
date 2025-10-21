-- foldrを自分で書いてみる
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ e [] = e
foldr' f e (x : xs) = f x (foldr' f e xs)

main :: IO ()
main = do
  print $ foldr (*) 2 [1, 2, 3, 4] -- 2 * (1 * 2 * 3 * 4) = 48
  print $ foldr (+) 2 [1, 2, 3, 4] -- 2 + (1 + 2 + 3 + 4) = 12
  print $ foldr' (*) 2 [1, 2, 3, 4] -- 2 * (1 * 2 * 3 * 4) = 48
  print $ foldr' (+) 2 [1, 2, 3, 4] -- 2 + (1 + 2 + 3 + 4) = 12