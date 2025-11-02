import Data.Set qualified as Set

main :: IO ()
main = do
  print $ (Set.toList . Set.fromList) [1, 1, 2, 3, 5, 8] -- [1,2,3,5,8]