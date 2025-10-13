insideRectangle :: Int -> Int -> Int -> Int -> Int -> String
insideRectangle w h x y r
  | x < 0 || y < 0 = "No"
  | w - r >= x && h - r >= y = "Yes"
  | otherwise = "No"

main :: IO ()
main = do
  [w, h, x, y, r] <- map read . words <$> getLine :: IO [Int]
  let result = insideRectangle w h x y r
  putStrLn result