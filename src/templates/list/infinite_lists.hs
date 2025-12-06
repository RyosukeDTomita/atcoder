main :: IO ()
main = do
  -- replicateは有限リストしか作れない上に、Intのみしか使えない
  print $ replicate 10 1
  -- repeatは値を繰り返す
  print $ take 10 (repeat 0)
  -- cycleは配列を繰り返す
  print $ take 10 (cycle "01")
  print $ take 10 (cycle "#.")
  print $ take 10 (cycle [1, 2, 3])