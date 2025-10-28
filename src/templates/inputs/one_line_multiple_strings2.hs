main :: IO ()
main = do
  [greeting, name] <- words <$> getLine
  print greeting
  print name