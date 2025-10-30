main :: IO ()
main = do
  -- ghci>  map (80 `mod`) [5..14]
  -- [0,2,3,0,8,0,3,8,2,10]
  -- ghci> filter (\x -> 80 `mod` x == 0) [5..14]
  -- [5,8,10]
  [a, b, c] <- map read . words <$> getLine :: IO [Int]
  -- print $ length . filter (\x -> c `mod` x == 0) [a .. b] --これはエラーになるなぜなら、filterが先に適用されてしまい、length . [1, 2, 3]のようになるから
  -- print $ (length . filter (\x -> c `mod` x == 0)) [a .. b] -- これならOK
  print $ length $ filter (\x -> c `mod` x == 0) [a .. b] -- これが一番シンプルな気がする
