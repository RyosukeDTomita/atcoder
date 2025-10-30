import Filter (filter')
import Fold (foldl', foldr')
import Length (length', length'')
import Map (map', map'')
import Scan (scanl', scanr')
import Zip (zip', zipWith')

main :: IO ()
main = do
  -- length
  print $ length' [1, 2, 3]
  print $ length'' [1, 2, 3]

  -- foldr, foldl
  print $ foldr' (+) 5 [1, 2, 3, 4]
  print $ foldl' (+) 5 [1, 2, 3, 4]

  -- filter
  print $ filter' (< 3) [1, 2, 3, 4]

  -- zip, zipWith
  print $ zipWith' (+) [1, 2, 3] [4, 5]
  print $ zip' ["Alice", "Bob", "Charlie"] [80, 90, 75]

  -- map
  print $ map' show [1, 2, 3, 4]
  print $ map'' show [1, 2, 3, 4]

  -- scanl, scanr
  print $ scanl' (+) 5 [1, 2, 3, 4]
  print $ scanr (+) 5 [1, 2, 3, 4]