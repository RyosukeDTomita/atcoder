-- zipWithを自分で定義してみる
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c] -- (a -> b -> c)は関数
zipWith' _ [] _ = [] -- 第1リストが空なら終了
zipWith' _ _ [] = [] -- 第2リストが空なら終了
zipWith' f (a : as) (b : bs) = f a b : zipWith' f as bs -- 両方に要素があれば処理

main :: IO ()
main = do
  print $ zipWith (+) [1, 2, 3] [4, 5] -- [5, 7]
  print $ zipWith' (+) [1, 2, 3] [4, 5] -- [5, 7]