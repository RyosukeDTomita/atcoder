import Data.Int (Int64)

main :: IO ()
main = do
  -- 良くない例
  let a = 2 ^ 35 :: Integer
  print ((a * a) `mod` 131)

  -- 計算途中でmodするかつ固定長のInt64を使うと高速
  let b = 2 ^ 35 :: Int64
  print ((b * b) `mod` 131) -- b * bがオーバーフローしているため誤り
  print ((b `mod` 131) * (b `mod` 131) `mod` 131) -- 分割することで正しく計算できる