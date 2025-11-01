simpleSort :: (Int, Int) -> (Int, Int)
simpleSort (x, y) =
  if x >= y
    then (y, x)
    else (x, y)

main :: IO ()
main = do
  print (simpleSort (3, 5))
  print (simpleSort (6, 5))
