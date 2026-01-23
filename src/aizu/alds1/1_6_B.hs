-- partition関数: 配列を基準値(最後の要素)で分割
-- 基準値以下の要素を左側に、基準値より大きい要素を右側に配置
partition :: [Int] -> String
partition [] = ""
partition xs =
  let pivot = last xs -- 最後の要素を基準として選択
      rest = init xs -- 最後の要素以外
      smaller = filter (<= pivot) rest -- ピボット以下の要素
      larger = filter (> pivot) rest -- ピボットより大きい要素
   in unwords $ map show smaller ++ ["[" ++ show pivot ++ "]"] ++ map show larger

main :: IO ()
main = interact $ \input ->
  let ls = lines input
      xs = map read . words $ ls !! 1 :: [Int]
   in partition xs ++ "\n"