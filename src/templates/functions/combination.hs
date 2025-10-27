nCr :: Integer -> Integer -> Integer
-- nCr n r = foldl (*) 1 [n - r + 1 .. n] `div` foldl (*) 1 [1 .. r]
nCr n r = product [n - r + 1 .. n] `div` product [1 .. r]

main :: IO ()
main = do
  print $ 5 `nCr` 2