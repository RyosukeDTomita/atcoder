-- zipを自分で定義する
zip' :: [a] -> [b] -> [(a, b)]
zip' = zipWith (,)

main :: IO ()
main = do
  print $ zip [1, 2] [3, 4, 5] -- [(1,3),(2,4)]
  print $ zip' [1, 2] [3, 4, 5]
  let names = ["Alice", "Bob", "Charlie"]
  let scores = [80, 90, 75]
  print $ zip names scores
