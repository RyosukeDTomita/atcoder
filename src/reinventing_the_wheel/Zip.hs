module Zip (zipWith', zip') where

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c] -- (a -> b -> c)は関数
zipWith' _ [] _ = [] -- 第1リストが空なら終了
zipWith' _ _ [] = [] -- 第2リストが空なら終了
zipWith' f (a : as) (b : bs) = f a b : zipWith' f as bs -- 両方に要素があれば処理
-- e.g. zipWith' (+) [1, 2, 3] [4, 5]の場合
-- = zipWith' (+) (1: [2, 3]) (4: [5])
-- = (+) 1 4 : zipWith' (+) [2, 3] [5]
-- = 5 : zipWith' (+) [2, 3] [5]
-- = 5 : (+) 2 5 : zipWith' (+) [3] []
-- = 5 : 7 : zipWith' (+) [3] []
-- = 5 : 7 : []
-- = [5, 7]

zip' :: [a] -> [b] -> [(a, b)]
zip' list1 list2 = zipWith (,) list1 list2

-- e.g. zip' ["Alice", "Bob", "Charlie"] [80, 90, 75]の場合
-- = zipWith (,) ["Alice", "Bob", "Charlie"] [80, 90, 75]
-- = (,) "Alice" 80 : zipWith ["Bob", "Charlie"] [80, 90, 75]
-- = ("Alice", 80) : zipWith ["Bob", "Charlie"] [90, 75]
-- = ("Alice", 80) : (,) "Bob" 90 : zipWith ["Charlie"] [75]
-- = ("Alice", 80) : ("Bob", 90) : zipWith ["Charlie"] [75]
-- = ("Alice", 80) : ("Bob", 90) : (,) "Charlie" 75 : zipWith [] []
-- = ("Alice", 80) : ("Bob", 90) : ("Charlie", 75) : []
-- = [("Alice", 80), ("Bob", 90), ("Charlie", 75)]

main :: IO ()
main = do
  print $ zipWith' (+) [1, 2, 3] [4, 5] -- [5, 7]
  print $ zip' ["Alice", "Bob", "Charlie"] [80, 90, 75] -- [("Alice",80),("Bob",90),("Charlie",75)]