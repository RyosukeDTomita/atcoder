compareAB :: Int -> Int -> String
compareAB a b
  | a > b = "a > b"
  | a < b = "a < b"
  | otherwise = "a == b"

main :: IO ()
main = do
  [a, b] <- map read . words <$> getLine :: IO [Int] -- fmap (*2) [1, 2, 3] = [2, 4, 6] = (*2) <$> [1, 2, 3]
  -- if式でも良い。
  -- let result =
  --       if a > b
  --         then "a > b"
  --         else
  --           if a < b
  --             then "a < b"
  --             else "a == b"
  -- ガード式の方が簡潔
  let result = compareAB a b
  putStrLn result