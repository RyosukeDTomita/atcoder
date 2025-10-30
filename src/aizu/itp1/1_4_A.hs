import Text.Printf (printf)

main :: IO ()
main = do
  [a, b] <- map read . words <$> getLine :: IO [Int]
  let divResult = a `div` b
  let modResult = a `mod` b
  let floatDiv = fromIntegral a / fromIntegral b :: Double
  printf "%d %d %.5f\n" divResult modResult floatDiv
