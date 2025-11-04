module Concat (concat', concat'', concatMap', concatMap'') where

-- リスト専用版
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x : xs) = x ++ concat' xs

-- Foldable版（より汎用的）
concat'' :: (Foldable t) => t [a] -> [a]
concat'' = foldr (++) []

-- 再帰で表現（リスト専用版）
concatMap' :: (a -> [b]) -> [a] -> [b] -- (a -> [b])はaの型を受け取ってb型のリストを返す関数
concatMap' _ [] = []
concatMap' f (x : xs) = f x ++ concatMap' f xs

-- Foldable版
concatMap'' :: (Foldable t) => (a -> [b]) -> t a -> [b]
concatMap'' f xs = foldr ((++) . f) [] xs

-- e.g. concatMap'' show [1, 2, 3]の場合
-- foldr ((++) . show) [] [1, 2, 3]
-- foldr ((++) . show) [] (1: [2, 3])
-- = ((++) . show) 1 (foldr [] [2, 3])
-- = (++) "1" (foldr [] [2, 3])
-- = (++) "1" (((++) . show) 2 (foldr [] [3]))
-- = (++) "1" ((++) "2" (foldr [] [3]))
-- = (++) "1" ((++) "2" (((++) . show) 3 (foldr [] [])))
-- = (++) "1" ((++) "2" (((++) "3" ([])))
-- = (++) "1" ((++) "2" ((++) "3" ([]))
-- = (++) "1" ((++) "2" ("3"))
-- = (++) "1" ("23")
-- = "123"

main :: IO ()
main = do
  -- concat
  -- リスト版
  print $ concat' [[1, 2, 3], [4, 5], [6]] -- [1,2,3,4,5,6]
  print $ concat' ["Hello", " ", "World"] -- "Hello World"

  -- Foldable版（MaybeやTreeなども使える）
  print $ concat'' [[1, 2], [3, 4]] -- [1,2,3,4]
  print $ concat'' (Just [1, 2, 3]) -- [1,2,3]
  print $ concat'' (Nothing :: Maybe [Int]) -- []

  -- concatMap
  -- concatMapをconcatとmapの関数合成で再現する
  print $ (concat . map show) [1, 2, 3]
  -- NOTE: リストを返す関数しか適用できない。
  -- ghci> (concat . map show) [1,2,3,4,5]
  -- "12345"
  -- ghci> concatMap show [1,2,3,4,5]
  -- "12345"

  -- リストでconcatMapの動きを再現する
  print $ concatMap' show [1, 2, 3]
  -- foldr版(リスト以外でも使える)
  print $ concatMap'' show [1, 2, 3]
  print $ concatMap'' show (Just [1, 2, 3]) -- "[1,2,3]"
