main :: IO ()
main = do
  [a, b] <- map read . words <$> getLine
  if even (a * b)
    then
      putStrLn "Even"
    else
      putStrLn "Odd"