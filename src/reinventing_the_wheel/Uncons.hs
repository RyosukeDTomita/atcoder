module Uncons (uncons', unsnoc') where

uncons' :: [a] -> Maybe (a, [a])
uncons' [] = Nothing
uncons' (x : rest) = Just (x, rest)

-- uncons活用のための関数。パターンマッチでもかけるけど
headPlusLength :: [Int] -> Int
headPlusLength xs =
  case uncons' xs of -- 関数内で分岐したい時に使う
    Just (x, xs') -> x + length xs'
    Nothing -> -999

unsnoc' :: [a] -> Maybe ([a], a)
-- NOTE: ~は遅延パターン
-- maybe :: b -> (a -> b) -> Maybe a -> b
-- maybe :: デフォルト値 -> 値があるときの関数 -> Just a or Nothing -> bであることに注意。
unsnoc' xs = foldr (\x -> Just . maybe ([], x) (\(~(a, b)) -> (x : a, b))) Nothing xs

-- 遅い
-- NOTE: GHCのlastは内部的には`foldl`を使っている
unsnocL :: [a] -> Maybe ([a], a)
unsnocL xs = foldl step Nothing xs
  where
    step Nothing x = Just ([], x)
    step (Just (acc, y)) x = Just (acc ++ [y], x)

main :: IO ()
main = do
  print $ headPlusLength [1, 2, 3, 4, 5] -- 1 + 4 = 5
  print $ headPlusLength [1]
  print $ headPlusLength [] -- -999
  print $ unsnoc' [1, 2, 3, 4, 5] -- ([1,2,3,4,], 5)
  print $ unsnocL [1, 2, 3, 4, 5] -- ([1,2,3,4,], 5)