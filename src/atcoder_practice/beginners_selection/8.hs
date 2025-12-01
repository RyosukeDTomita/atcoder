import Data.Set qualified as Set

solve :: [Int] -> Int
solve ds = length $ eraseDuplicate ds

-- set型を使って重複削除
eraseDuplicate :: [Int] -> [Int]
eraseDuplicate ds = (Set.toList . Set.fromList) ds

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      ds = map read $ tail ls :: [Int]
   in show (solve ds) ++ "\n"
