main :: IO ()
main = do
  [s, a, b, x] <- map read . words <$> getLine :: IO [Int]
  let n = x `div` (a + b)
  let r = x `mod` (a + b)
  -- s m/sでa秒間走ることをr > aならn + 1回行える
  -- r < aの場合には s m/sでa秒間をn回走った後に、追加で r秒間走れる
  -- r == aの場合はmodなので発生しない
  if r > a
    then print (s * a * (n + 1))
    else print ((s * a * n) + (s * r))
