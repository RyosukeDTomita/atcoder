main :: IO ()
main = do
  nameList <- words <$> getLine
  print nameList