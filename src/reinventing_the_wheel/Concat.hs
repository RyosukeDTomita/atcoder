module Concat (concat', concat'') where

-- リスト専用版
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x : xs) = x ++ concat' xs

-- Foldable版（より汎用的）
concat'' :: (Foldable t) => t [a] -> [a]
concat'' = foldr (++) []

main :: IO ()
main = do
  -- リスト版
  print $ concat' [[1, 2, 3], [4, 5], [6]] -- [1,2,3,4,5,6]
  print $ concat' ["Hello", " ", "World"] -- "Hello World"

  -- Foldable版（MaybeやTreeなども使える）
  print $ concat'' [[1, 2], [3, 4]] -- [1,2,3,4]
  print $ concat'' (Just [1, 2, 3]) -- [1,2,3]
  print $ concat'' (Nothing :: Maybe [Int]) -- []
