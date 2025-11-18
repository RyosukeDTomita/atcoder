-- 冒頭で行数がわかる場合 (interact版)
main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read (head ls) :: Int
      intList = map read . take n $ tail ls :: [Int] -- 大抵の場合tail lsだけで良さそうだが、下にデータが続く可能性を考慮してtakeをつけている。
   in unlines (map show intList)