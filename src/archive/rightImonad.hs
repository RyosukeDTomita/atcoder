-- モナド則2: 右単位元則
-- m >>= return = m

main :: IO ()
main = do
  -- Just の場合
  let m1 = Just 5 :: Maybe Int
  let leftSide1 = m1 >>= return
  let rightSide1 = m1

  putStrLn $ "左辺 (m >>= return): " ++ show leftSide1
  putStrLn $ "右辺 (m): " ++ show rightSide1