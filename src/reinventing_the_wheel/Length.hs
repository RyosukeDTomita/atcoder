module Length (length', length'') where

length' :: [a] -> Int
length' [] = 0
length' (_ : xs) = 1 + length' xs

-- foldrを使うバージョン
length'' :: [a] -> Int
length'' xs = foldr (\_ acc -> acc + 1) 0 xs -- accはaccumulator(累積値の略)
-- length'' [1, 2, 3]
-- foldr (\_ acc -> acc + 1) 0 [1, 2, 3]
-- (\_ acc -> acc + 1) 1 foldr (\_ acc -> acc + 1) 0 [2, 3]
-- (\_ acc -> acc + 1) 1 (\_ acc -> acc + 1) 2 foldr (\_ acc -> acc + 1) 0 [3]
-- (\_ acc -> acc + 1) 1 (\_ acc -> acc + 1) 2 (\_ acc -> acc + 1) 3 foldr (\_ acc -> acc + 1) 0 []
-- (\_ acc -> acc + 1) 1 (\_ acc -> acc + 1) 2 (\_ acc -> acc + 1) 3 0
-- (\_ acc -> acc + 1) 1 (\_ acc -> acc + 1) 2 1
-- (\_ acc -> acc + 1) 1 2
-- 3

main :: IO ()
main = do
  print $ length' [1, 2, 3]
  print $ length'' [1, 2, 3]