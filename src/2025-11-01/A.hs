main :: IO ()
main = do
  [a, b, c, d] <- map read . words <$> getLine :: IO [Int]
  if c >= a && b > d
    then putStrLn "Yes"
    else putStrLn "No"
