module Filter (filter') where

filter' :: (a -> Bool) -> [a] -> [a]
-- 第一引数fが関数、第2引数がリスト
filter' f [] = []
filter' f (x : xs)
  | f x = x : filter' f xs -- f xの結果がTrueの場合、xは結果に含めるためリストの連結をしている。
  | otherwise = filter' f xs -- f xの結果がFalseの場合は残りの要素で再帰
  -- e.g. filter' (< 3) [1, 2, 3, 4]の場合
  -- = filter' (<3) 1 : [2, 3, 4]
  -- = 1 : filter' (< 3) [2, 3, 4]
  -- = 1 : 2 : filter' (< 3) [3, 4]
  -- = 1 : 2 : filter' (< 3) [4]
  -- = 1 : 2 : filter' (< 3) []
  -- = 1 : 2 : []
  -- = [1, 2]

main :: IO ()
main = do
  print $ filter' (< 3) [1, 2, 3, 4]