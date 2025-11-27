import Data.List (transpose)

main :: IO ()
main = do
  let xs = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  print xs
  print $ transpose xs
