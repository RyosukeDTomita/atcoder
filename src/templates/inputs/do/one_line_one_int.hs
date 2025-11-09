main :: IO ()
main = do
  -- n <- getLine >>= readIO :: IO Int -- readLnはgetLineとreadIOを組み合わせたもの
  n <- readLn :: IO Int
  print n