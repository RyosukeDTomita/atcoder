-- ソート済みリストと交換回数を返す
bubbleSort :: (Ord a) => [a] -> ([a], Int)
bubbleSort xs =
  -- リストの数だけ再帰する
  go xs (length xs) 0
  where
    go xs 0 cnt = (xs, cnt)
    go xs n cnt =
      let (xs', swapped) = bubble xs 0
       in go xs' (n - 1) (cnt + swapped)

    -- 隣同士を比較して交換する関数（交換回数も返す）
    bubble (x : y : zs) cnt
      | x > y = let (rest, c) = bubble (x : zs) (cnt + 1) in (y : rest, c)
      | otherwise = let (rest, c) = bubble (y : zs) cnt in (x : rest, c)
    bubble xs cnt = (xs, cnt) -- リストのサイズが2未満になった時

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map (read :: String -> Int) . words $ ls !! 1
      (sorted, cnt) = bubbleSort xs
   in (unwords . map show $ sorted) ++ "\n" ++ show cnt ++ "\n"