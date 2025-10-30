cal :: String -> Integer
cal equation =
  let parts = words equation
      a = read (parts !! 0) :: Integer
      op = head (parts !! 1)
      b = read (parts !! 2) :: Integer
   in case op of
        '+' -> a + b
        '-' -> a - b
        '*' -> a * b
        '/' -> a `div` b
        _ -> error "Unknown operator"

main :: IO ()
main = do
  equations <- filter (\s -> not (null s) && notElem '?' s) . lines <$> getContents
  mapM_ (print . cal) equations
