-- aが何回2で割り切れるかを調べる関数
isPowerOf2 :: Int -> Int -> Int
isPowerOf2 a n =
  if even a
    then isPowerOf2 (a `div` 2) (n + 1)
    else n

main :: IO ()
main = do
  n <- readLn :: IO Int
  as <- map read . words <$> getLine :: IO [Int]
  print $ minimum $ map (\a -> isPowerOf2 a 0) as
