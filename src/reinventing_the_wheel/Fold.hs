module Fold (foldr', foldl') where

import Data.Maybe (fromMaybe)

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

-- こう書いたほうがわかりやすいかも
foldl'' :: (b -> a -> b) -> b -> [a] -> b
foldl'' _ acc [] = acc -- 累積値
foldl'' f acc (x : xs) =
  let acc' = f acc x
   in foldl'' f acc' xs

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f xs =
  fromMaybe
    (errorWithoutStackTrace "foldr1: empty structure")
    (foldr mf Nothing xs)
  where
    mf x m =
      Just
        ( case m of
            Nothing -> x
            Just y -> f x y
        )

-- foldl1はすべて同じ型
foldl1' :: (a -> a -> a) -> [a] -> a
foldl1' f xs =
  fromMaybe
    (errorWithoutStackTrace "foldl1: empty structure")
    (foldl mf Nothing xs)
  where
    mf m y =
      Just
        ( case m of
            Nothing -> y
            Just x -> f x y
        )

main :: IO ()
main = do
  print $ foldr' (+) 5 [1, 2, 3, 4]
  print $ foldl' (+) 5 [1, 2, 3, 4]

  print $ foldl' max 0 [1, 5, 3]
  print $ foldl1' max [1, 5, 3]
