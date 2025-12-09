-- Selection Sort: 交換回数をカウント
selectionSort :: (Ord a) => [a] -> ([a], Int)
selectionSort xs = go xs 0
  where
    go [] cnt = ([], cnt)
    go (x : rest) cnt =
      let minVal = minimum (x : rest)
          -- 最小値が先頭でなければ交換が必要
          swapped = if x == minVal then 0 else 1
          -- 最小値を取り除いて、先頭の値をその位置に入れる
          rest' =
            if x == minVal
              then rest -- 交換不要
              else
                let (before, _ : after) = break (== minVal) rest
                 in before ++ [x] ++ after -- 交換
          (sorted, c) = go rest' (cnt + swapped)
       in (minVal : sorted, c)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map (read :: String -> Int) . words $ ls !! 1
      (sorted, cnt) = selectionSort xs
   in (unwords . map show $ sorted) ++ "\n" ++ show cnt ++ "\n"