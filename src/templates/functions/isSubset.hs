import Data.Set qualified as Set

-- リストAがリストBの部分集合であるかチェックする
isSubSet :: (Ord a) => [a] -> [a] -> Bool
isSubSet listA listB = Set.fromList listA `Set.isSubsetOf` Set.fromList listB

main :: IO ()
main = do
  print $ "abcd" `isSubSet` ['a' .. 'z'] -- True
  print $ "Abcd" `isSubSet` ['a' .. 'z'] -- False
  print $ [1, 2, 3] `isSubSet` [1 .. 10] -- True