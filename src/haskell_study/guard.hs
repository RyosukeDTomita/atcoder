describeTemp :: Int -> String
describeTemp x
  | x == 100 = "boiling point"
  | x < 0 = "Below freezing"
  | otherwise = show x ++ "degree"

main :: IO ()
main = do
  print (describeTemp 100)
  print (describeTemp 50)
  print (describeTemp (-50))
