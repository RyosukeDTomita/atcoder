main :: IO ()
main = do
  let xs = [1, 2, 3]
  putStr $ unlines $ map show xs