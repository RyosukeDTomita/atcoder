main :: IO ()
main = do
  ss <- getLine
  print $ length $ filter (\x -> x == '1') ss