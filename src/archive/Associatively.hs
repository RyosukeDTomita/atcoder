-- 結合律
main :: IO ()
main = do
  let m = Just 3
      f x = Just (x + 1)
      g x = Just (x * 2)

  let left = (m >>= f) >>= g
      right = m >>= (\x -> f x >>= g)

  putStrLn $ "左辺 (m >>= f) >>= g  = " ++ show left -- mからfを適用してその結果をgに渡す
  putStrLn $ "右辺 m >>= (\\x -> f x >>= g) = " ++ show right -- mの値xに対してf xを計算し、その結果をgに渡す。
