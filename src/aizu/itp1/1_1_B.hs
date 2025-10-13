main :: IO ()
main = do
  x <- readLn :: IO Int
  -- print (x * x * x)
  print (x ^ 3)
