import Data.List (mapAccumL)

-- ソート中の状態を配列すべてにおいて見えるようにしたもの(mapAccumLを使用)
-- 出力例
-- 5 2 4 6 1 3
-- 2 5 4 6 1 3
-- 2 4 5 6 1 3
-- 2 4 5 6 1 3
-- 1 2 4 5 6 3
-- 1 2 3 4 5 6
insertSort :: (Ord a) => [a] -> [[a]]
insertSort xs = snd $ mapAccumL step ([], xs) xs -- mapAccumL step (ソート済みの領域の初期値, 未ソート領域の初期値) xs
  where
    step (sorted, _ : rest) x =
      let sorted' = insert x sorted
          row = sorted' ++ rest -- 途中の状態をすべて出力するために、ソート済みと未ソート領域を足したものを用意している。
       in ((sorted', rest), row) -- rowはmapAccumLに保存されるだけで畳み込みには使用されない。
    insert x [] = [x]
    insert x (y : ys) -- xをyとysの間に入れられるか調べる
      | x <= y = x : y : ys -- yの前にxを入れる
      | otherwise = y : insert x ys -- yとysの間にxは入れられることがわかったので、再帰してxを入れる適切な位置を探す。

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map (read :: String -> Int) . words $ ls !! 1
   in unlines $ map (unwords . map show) $ insertSort xs
