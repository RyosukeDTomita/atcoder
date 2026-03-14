-- Memory Limit Exceeded
countingSort :: [Int] -> [Int]
countingSort [] = []
countingSort xs =
  let maxX = maximum xs
      minX = minimum xs
      range = maxX - minX + 1
      -- 初期化：すべて0のリストを作成
      initCounts = replicate range 0
      -- 各値の出現回数をカウント（リストの更新はO(n)なので全体でO(n²)）
      updateCount :: [Int] -> Int -> [Int]
      updateCount counts x =
        let idx = x - minX
            (before, current : after) = splitAt idx counts
         in before ++ (current + 1) : after
      counts = foldl updateCount initCounts xs
      -- カウント配列から元のリストを再構築
      expand (i, count) = replicate count (i + minX)
   in concatMap expand (zip [0 ..] counts)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        xs = map read . words $ ls !! 1 :: [Int]
     in unwords (map show (countingSort xs)) ++ "\n"
