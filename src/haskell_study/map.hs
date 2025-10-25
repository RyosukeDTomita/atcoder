-- mapを自分で実装してみる
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs -- 先頭要素に引数で渡された関数を渡して連結する

-- foldrで実装する
map'' :: (a -> b) -> [a] -> [b]
map'' f = foldr ((:) . f) []

main :: IO ()
main = do
  print $ map show [1, 2, 3, 4, 5]
  print $ map' show [1, 2, 3, 4, 5]

  print $ foldr (:) [] [1, 2, 3, 4, 5] -- そのままリストを返す
  -- (;) 1 (foldr (;) [] [2, 3, 4, 5]) ...
  -- そのため、:にfを関数合成することでmapが作れる。(map'')を参照。
  print $ map'' show [1, 2, 3, 4, 5]