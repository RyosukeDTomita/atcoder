main :: IO ()
main = do
  intList <- map read . words <$> getLine :: IO [Int]
  print intList