-- ソート中の状態を配列すべてにおいて見えるようにしたもの(mapAccumLを使用しない)
-- 出力例
-- 5 2 4 6 1 3
-- 2 5 4 6 1 3
-- 2 4 5 6 1 3
-- 2 4 5 6 1 3
-- 1 2 4 5 6 3
-- 1 2 3 4 5 6
insertSort :: (Ord a) => [a] -> [[a]]
insertSort xs =
  let steps = scanl step ([], xs) [1 .. length xs]
   in tail $ map (\(sorted, rest) -> sorted ++ rest) steps -- NOTE: scanlは初期値を出力するのでtailで捨てている。
  where
    step (sorted, r : rs) _ = (insert r sorted, rs) -- 連結するためにタプルでrsも持つ
    insert x [] = [x]
    insert x (y : ys)
      | x <= y = x : y : ys
      | otherwise = y : insert x ys

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map (read :: String -> Int) . words $ ls !! 1
   in unlines $ map (unwords . map show) $ insertSort xs
