import Data.List (partition)

main :: IO ()
main = do
  print $ partition (> 3) [1, 2, 3, 4, 5] -- ([4, 5], [1, 2, 3])