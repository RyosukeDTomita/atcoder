main :: IO ()
main = do
  intList <- map read . lines <$> getContents :: IO [Int]
  print intList