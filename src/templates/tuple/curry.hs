isValid :: (Int, Int) -> Int -> Bool
isValid (l, h) x = l <= x && x <= h

main :: IO ()
main = do
  let xy = (1, 2)
  -- uncurryを使うと引数をTupleで渡せる
  print $ uncurry (+) xy -- 1 + 2

  -- curryを使うとtupleで定義された関数を部分適用できる
  let inRange :: Int -> Bool
      inRange = curry isValid 10 20

  print $ inRange 5 -- False
  print $ inRange 15 -- True
