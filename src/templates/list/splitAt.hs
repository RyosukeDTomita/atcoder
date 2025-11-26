main :: IO ()
main = do
  let xs = [1, 2, 3, 4, 5]
  let (front, back) = splitAt 2 xs -- [1,2]と[3,4,5]に分割
  print front
  print back
  print $ back ++ front -- カードのシャッフルとかに使える