inf = maxBound `div` 2 :: Int -- minの加算でオーバーフローしないために半分にする

main :: IO ()
main = do
  print $ min 100 inf
