main :: IO ()
main = do
  xs <- lines <$> getContents
  print xs