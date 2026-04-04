main :: IO ()
main = do
  -- replicateは有限リストしか作れない上に、Intのみしか使えない。単一の値からなるリスト
  print $ replicate 10 1
  -- repeatは値を無限に繰り返す。
  print $ take 10 (repeat 0)
  -- cycleはリストを無限に繰り返す
  print $ take 10 (cycle "01")
  print $ take 10 (cycle "#.")
  print $ take 10 (cycle [1, 2, 3])
