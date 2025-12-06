main :: IO ()
main = do
  -- splitAtを使った分割はindexで分割をする
  let xs = [1, 2, 3, 4, 5]
  let (front, back) = splitAt 2 xs -- [1,2]と[3,4,5]に分割
  print front
  print back
  print $ back ++ front -- カードのシャッフルとかに使える

  -- spanとbreakを使った分割は条件をTrue/Falseを満たすものが登場した場所で分割する
  print $ span (> 3) [1, 2, 3, 4, 5] -- ([], [1,2,3,4,5])
  print $ span (> 3) [5, 4, 3, 2, 1, 4] -- ([5,4], [3,2,1,4])
  print $ break (<= 3) [1, 2, 3, 4, 5] -- ([], [1,2,3,4,5])
  print $ break (<= 3) [5, 4, 3, 2, 1, 4] -- ([5,4], [3,2,1,4])