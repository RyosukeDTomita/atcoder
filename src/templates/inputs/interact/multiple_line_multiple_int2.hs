-- 冒頭で行の数が示されている場合の二次元のinput (interact版)
main :: IO ()
main = interact $ \input ->
  let ls = lines input
      [h, _] = map read . words $ head ls
      intList = map (map read . words) . take h $ tail ls :: [[Int]]
   in show intList ++ "\n"
