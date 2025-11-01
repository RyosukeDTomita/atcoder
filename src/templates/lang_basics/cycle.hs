main :: IO ()
main = do
  print $ take 10 (cycle "01")
  print $ take 10 (cycle "#.")