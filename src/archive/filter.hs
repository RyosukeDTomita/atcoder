-- 自分でfilterを定義し直してみる
filter' :: (a -> Bool) -> [a] -> [a]
-- 第一引数pが関数、第2引数がリスト
filter' p [] = []
filter' p (x : xs)
  | p x = x : filter' p xs -- p xの結果たTrueの場合、xは結果に含めるためリストの連結をしている。その他で再帰
  | otherwise = filter' p xs

main :: IO ()
main = do
  print $ filter (< 3) [1, 2, 3, 4, 5]
  print $ filter' (< 3) [1, 2, 3, 4, 5]