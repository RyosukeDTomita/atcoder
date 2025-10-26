main :: IO ()
main = do
  let aList = [1, 2, 3]
  if 1 `elem` aList
    then putStrLn "Yes"
    else putStrLn "No"