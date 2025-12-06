-- ACできないが途中過程を見えるようにしたもの
insertSort :: (Ord a) => [a] -> [[a]]
insertSort xs = scanl (flip insert) [] xs -- foldlをscanlに書き換えた
  where
    insert x [] = [x]
    insert x (y : ys) -- xをyとysの間に入れられるか調べる
      | x <= y = x : y : ys -- yの前にxを入れる
      | otherwise = y : insert x ys -- yとysの間にxは入れられることがわかったので、再帰してxを入れる適切な位置を探す。

-- 出力例
-- 5
-- 2 5
-- 2 4 5
-- 2 4 5 6
-- 1 2 4 5 6
-- 1 2 3 4 5 6
main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map (read :: String -> Int) . words $ ls !! 1
   in unlines $ map (unwords . map show) $ insertSort xs

-- main :: IO ()
-- main = interact $ \inputs ->
--   let ls = lines inputs
--       xs = map (read :: String -> Int) . words $ ls !! 1
--    in (unwords . map show $ insertSort xs) ++ "\n"
