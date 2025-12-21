import Data.List (nub)
import Data.Set qualified as Set

eraseDuplicate :: (Ord a) => [a] -> [a]
eraseDuplicate xs = (Set.toList . Set.fromList) xs

main :: IO ()
main = do
  print $ nub [1, 1, 2, 3, 5, 8] -- nubは遅い(O(n^2)のため非推奨)
  print $ eraseDuplicate [1, 1, 2, 3, 5, 8] -- [1,2,3,5,8]
  print $ eraseDuplicate ["hoge", "fuga", "hoge"] -- ["hoge", "fuga"]