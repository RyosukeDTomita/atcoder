main :: IO ()
main = do
  let y = (\x -> x ** 2) 2 -- 4
  print y

  -- カリー化による2つの引数を取るlambda式
  let z = (\x y -> x ** 2 + y ** 2) 2 3
  print z