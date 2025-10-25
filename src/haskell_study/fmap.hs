main :: IO ()
main = do
  print $ fmap (+ 1) [1, 2, 3] -- [2, 3, 4]
  print $ (+ 1) <$> [1, 2, 3] -- [2, 3, 4]
  let test = [1, 2, 3]
  print $ test !! 2