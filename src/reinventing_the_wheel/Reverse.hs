module Reverse (reverse', reverse'', reverse''') where

-- 単純に逆順にする関数
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (a : as) = reverse' as ++ [a] -- 配列の先頭を取り出して、末尾に連結する

reverse'' :: [a] -> [a]
reverse'' as = foldl (flip (:)) [] as

-- NOTE: flipは関数に渡す引数の順序を入れ替えて返す関数である。
-- ghci> (:) 1 [2,3]
-- [1,2,3]
--- ghci> flip (:) [2,3] 1
-- [1,2,3]
-- e.g. foldl (flip (:)) [] [1,2,3]の場合
-- foldl (flip (:)) ((flip (:)) [] 1) [2,3]
-- = foldl (flip (:)) ([1]) [2,3]
-- = foldl (flip (:)) ((flip (:)) [1] 2) [3]
-- = foldl (flip (:)) ([2, 1]) [3]
-- = foldl (flip (:)) ((flip (:)) [2, 1] 3) []
-- = foldl (flip (:)) ([3, 2, 1]) []
-- = [3, 2, 1]

reverse''' :: [a] -> [a]
reverse''' as = foldr (\x acc -> acc ++ [x]) [] as -- foldrにより末尾から順に値を取り出し、accに結合することで逆順にする。
-- e.g. foldr (\x acc -> acc ++ [x]) [] [1, 2, 3]の場合
-- (\x [] -> [] ++ [x]) 1 (foldr (\x acc -> acc ++ [x]) [] [2, 3])
-- (\x [] -> [] ++ [x]) 1 ((\x [] -> [] ++ [x]) 2 (foldr (\x acc -> acc ++ [x]) [] [3]))
-- = (\x acc -> acc ++ [x]) 1 ((\x acc -> acc ++ [x]) 2 ((\x acc -> acc ++ [x]) 3 (foldr (\x acc -> acc ++ [x]) [] [])))
-- = (\x acc -> acc ++ [x]) 1 ((\x acc -> acc ++ [x]) 2 ((\x acc -> acc ++ [x]) 3 [])
-- = (\x acc -> acc ++ [x]) 1 (\x acc -> acc ++ [x]) 2 [3]
-- = (\x acc -> acc ++ [x]) 1 ([3, 2])
-- = [3, 2, 1]

main :: IO ()
main = do
  print $ reverse' [1, 2, 3, 4] -- [4, 3, 2, 1]
  print $ reverse' "Hello, World!" -- "!dlroW ,olleH"
  print $ reverse' ["MIKE", "KEN"] -- ["KEN","MIKE"]
  print $ reverse'' [1, 2, 3, 4] -- [4, 3, 2, 1]
  print $ reverse''' [1, 2, 3, 4] -- [4, 3, 2, 1]