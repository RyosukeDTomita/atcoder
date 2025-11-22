module Fold (foldr', foldl') where

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ e [] = e -- 初期値
foldr' f e (x : xs) = f x (foldr' f e xs) -- 受け取る引数をlist構築式の形で処理している。:はリストを作る演算子である。
-- e.g. foldr' (+) 5 [1, 2, 3, 4]の場合
-- foldr' (+) 5 (1: [2, 3, 4])
-- = 1 + (foldr' 5 [2, 3, 4])
-- = 1 + 2 + (foldr' 5 [3, 4])
-- = 1 + 2 + 3 + (foldr' 5 [4])
-- = 1 + 2 + 3 + 4 + (foldr' 5 [])
-- = 1 + 2 + 3 + 4 + 5

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ acc [] = acc -- 累積値
foldl' f acc (x : xs) = foldl' f (f acc x) xs

-- e.g. foldl' (+) 5 [1, 2, 3, 4]の場合
-- = foldl' (+) 5 (1: [2, 3, 4])
-- = foldl' (+) ((+) 5 1) [2, 3, 4]
-- = foldl' (+) (6) [2, 3, 4]
-- = foldl' (+) ((+) 6 2) [3, 4]
-- = foldl' (+) (8) [3, 4]
-- = foldl' (+) ((+) 8 3) [4]
-- = foldl' (+) (11) [4]
-- = foldl' (+) ((+) 11 4) []
-- = foldl' (+) (15) []
-- = 15

main :: IO ()
main = do
  print $ foldr' (+) 5 [1, 2, 3, 4]
  print $ foldl' (+) 5 [1, 2, 3, 4]