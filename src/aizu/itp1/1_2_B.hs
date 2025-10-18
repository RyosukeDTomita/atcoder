judgeB :: Int -> Int -> Int -> String
judgeB a b c
  | a < b && b < c = "Yes" -- &&と||を使う
  | otherwise = "No"

main :: IO ()
main = do
  [a, b, c] <- map read . words <$> getLine :: IO [Int]
  let result = judgeB a b c
  putStrLn result