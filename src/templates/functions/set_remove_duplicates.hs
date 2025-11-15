import Data.Set qualified as Set

eraseDuplicate :: (Ord a) => [a] -> [a]
eraseDuplicate xs = (Set.toList . Set.fromList) xs

main :: IO ()
main = do
  print $ eraseDuplicate [1, 1, 2, 3, 5, 8] -- [1,2,3,5,8]
  print $ eraseDuplicate ["hoge", "fuga", "hoge"] -- ["hoge", "fuga"]