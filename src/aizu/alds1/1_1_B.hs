import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [a, b] = euclidean a b

-- ユークリッドの互助法
euclidean :: Int -> Int -> Int
euclidean a b
  | a `mod` b == 0 = b
  | otherwise = euclidean b (a `mod` b)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")