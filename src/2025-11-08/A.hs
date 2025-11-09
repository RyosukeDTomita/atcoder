main :: IO ()
main = do
  [h, b] <- map read . words <$> getLine :: IO [Int]
  if h > b
    then print (h - b)
    else print 0