-- zipWithを自分で定義してみる
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c] -- (a -> b -> c)は関数
zipWith' _ [] _ = []
zipWith' f (a : as) (b : bs) = f a b : zipWith' f as bs

main :: IO ()
main = do
  print $ zipWith (+) [1, 2, 3] [4, 5] -- [5, 7]