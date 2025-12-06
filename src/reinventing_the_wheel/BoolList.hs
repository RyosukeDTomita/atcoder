module BoolList (all', any', and', or') where

and' :: [Bool] -> Bool
and' xs = foldr (&&) True xs

or' :: [Bool] -> Bool
or' xs = foldr (||) False xs

all' :: (a -> Bool) -> [a] -> Bool
all' f xs = foldr (\x acc -> f x && acc) True xs

any' :: (a -> Bool) -> [a] -> Bool
any' f xs = foldr (\x acc -> f x || acc) False xs

main :: IO ()
main = do
  -- リストの要素が全てTrueか
  print $ and' [True, True, True] -- True
  print $ and' [True, True, False] -- False
  -- リストの要素が一つでもTrueか
  print $ or' [True, True, True] -- True
  print $ or' [True, True, False] -- True
  print $ or' [False, False, False] -- False

  -- 結果が全てTrueか
  print $ all' even [2, 4, 6] -- True
  print $ all' even [1, 2, 3] -- False

  -- 結果が一つでもTrueか
  print $ any' even [2, 4, 6] -- True
  print $ any' even [1, 2, 3] -- True
  print $ any' even [1, 3, 5] -- False