module Listdeconstruct (init', init'', last') where

init' :: [a] -> [a]
init' [] = error "empty list"
init' (x : xs) = go x xs
  where
    -- 再帰版よりも分岐が少ない
    go _ [] = []
    go y (z : zs) = y : go z zs

-- 再帰バージョン
-- パターンマッチが多くなる。
init'' :: [a] -> [a]
init'' [] = error "empty list"
init'' [x] = []
init'' (x : xs) = x : init'' xs

last' :: [a] -> a
-- GHCにはfoldlやfoldrのような標準的な畳み込み関数に対して、中間リストをメモリ上に生成せずに処理を合成する強力な最適化ルールがある。
-- NOTE: リストを作る側はproducer、リストを畳み込む側はconsumerと呼ぶ
last' xs = foldl (\_ x -> x) lastError xs
{-# INLINE last' #-}

-- INLINEをつけることで呼び出し側でlast'が展開される。
-- e.g. last' (map f xs)の場合: INLINEをつけることでfoldl (\_ x -> x) lastError (map f xs)まで
lastError :: a
lastError = error "empty list"

-- 再帰バージョン
last'' :: [a] -> a
last'' [] = error "empty list"
last'' [x] = x
last'' (_ : xs) = last'' xs

head' :: [a] -> a
head' (x : xs) = x

tail' :: [a] -> [a]
tail' (_ : xs) = xs -- 先頭とそれ以外にわけてそれ以外を返す

main :: IO ()
main = do
  -- init
  print $ init' [1, 2, 3] -- [1, 2]
  print $ init'' [1, 2, 3] -- [1, 2]
  -- last
  print $ init' [1, 2, 3] -- [2, 3]
  print $ init'' [1, 2, 3] -- [2, 3]
  -- head
  print $ head' [1, 2, 3]
  -- tail
  print $ tail' [1, 2, 3]