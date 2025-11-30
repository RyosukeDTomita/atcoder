main :: IO ()
main = do
  let a = 7 :: Int
  let b = 3 :: Int
  -- 整数の割り算
  print $ a `div` b -- 2
  print $ a `quot` b -- 2
  print $ (-a) `div` b -- -3 -- divは負数の時はfloorでまるめる
  -- ghci> floor (-2.3)
  -- -3
  -- ghci> floor 2.3
  -- 2
  -- 実数の割り算はfromIntegralを噛ませる必要がある。明示的にDoubleにするために型注釈をつけている。
  print $ (fromIntegral a :: Double) / (fromIntegral b :: Double)
  print $ (-a) `quot` b -- -2 -- quotは0に近づける方向でまるめる
  -- 余り
  print $ a `mod` b -- 1
  -- 商と余りをまとめてもとめる
  print $ a `divMod` b -- (2, 1)