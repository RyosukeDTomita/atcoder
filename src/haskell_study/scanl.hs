-- scanrを自分で書いてみる
scanl' :: (b -> a -> b) -> b -> [a] -> [b]
scanl' _ q [] = [q]
scanl' f q (x : xs) = q : scanl' f (f q x) xs

-- "ABC"に対し、"A", "B", "C", "AB", "BC", "ABC"を返す関数
segments :: [a] -> [[a]]
segments = foldr (++) [] . scanr (\a b -> [a] : map (a :) b) []

-- ghci > scanr (:) [] "ABC"
-- ["ABC", "BC", "C", ""]
-- ghci > scanr (:) [] ['A', 'B', 'C']
-- ["ABC", "BC", "C", ""]
-- ghci > (\a b -> [a] : map (a :) b) 'C' []
-- ["C"]
-- ghci > (\a b -> [a] : map (a :) b) 'B' ["C"]
-- ["B", "BC"]
-- ghci > (\a b -> [a] : map (a :) b) 'A' ["B", "BC"]
-- ["A", "AB", "ABC"]
-- よってscanr (\a b -> [a]: map (a:) b) [] ['A', 'B', 'C'] は[["A","AB","ABC"],["B","BC"],["C"],[]]に展開される。
-- 関数合成の定義より (f . g) x = f (gx)なので
-- foldr (++) [] [["A", "AB", "ABC"], ["B", "BC"], ["C"], []]
-- ["A","AB","ABC","B","BC","C"]

main :: IO ()
main = do
  -- NOTE: 初回は計算なしで第二引数が表示されることに注意
  print $ scanl (*) 2 [1, 2, 3, 4] -- [2, 2 * 1, 2 * 1 * 2, 2 * 1 * 2 * 3, 2 * 1 * 2 * 3 * 4] = [2, 2, 4, 12, 48]
  print $ scanl (+) 2 [1, 2, 3, 4] -- [2, 2 + 1, 2 + 1 + 2, 2 + 1 + 2 + 3, 2 + 1 + 2 + 3 + 4] = [2, 3, 5, 8, 12]
  print $ scanl' (*) 2 [1, 2, 3, 4]
  print $ scanl' (+) 2 [1, 2, 3, 4]

  print $ segments "ABC"