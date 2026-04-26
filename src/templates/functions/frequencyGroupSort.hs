import Data.List (group, sort)

frequency :: [Int] -> [(Int, Int)]
frequency xs = map (\g -> (head g, length g)) $ group $ sort xs

main :: IO ()
main = do
  print $ group $ sort [1, 2, 1, 2, 9] -- [[1,1],[2,2],[9]]
  print $ frequency [1, 2, 1, 2, 9] -- [(1,2),(2,2),(9,1)]
