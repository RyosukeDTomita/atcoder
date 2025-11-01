main :: IO ()
main = do
  let x = Just 3
  case x of
    Nothing -> putStrLn "No Value!"
    Just val -> putStrLn ("value is " ++ show val)