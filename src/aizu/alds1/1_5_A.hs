import Data.List (subsequences)

solve :: [Int] -> [Int] -> [String]
solve as ms =
  let allPattern = map sum $ subsequences as
   in map (\m -> if m `elem` allPattern then "yes" else "no") ms
  where
    go current (a : rest) m
      | a == m = "yes"
      | a > m = "no"
      | a < m = go (current + a) rest m

main :: IO ()
main = interact $ \input ->
  let ls = lines input
      n = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
      q = read $ ls !! 2 :: Int
      ms = map read . words $ ls !! 3 :: [Int]
   in unlines $ solve as ms