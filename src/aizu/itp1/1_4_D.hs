main :: IO ()
main = do
  _ <- readLn :: IO Int
  aList <- map read . words <$> getLine :: IO [Int]
  putStrLn $ unwords . map show $ [minimum aList, maximum aList, sum aList]