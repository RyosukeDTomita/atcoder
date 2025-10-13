import Data.List (sort)

main :: IO ()
main = do
  threeIntegers <- map read . words <$> getLine :: IO [Int]
  putStrLn . unwords . map show $ sort threeIntegers