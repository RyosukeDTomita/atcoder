main :: IO ()
main = do
  input <- lines <$> getContents
  let sList = takeWhile (/= "END") input
  print sList