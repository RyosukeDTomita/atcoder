solve :: [Int] -> Int
solve xs = length $ filter (isPrime) xs

isPrime :: Int -> Bool
isPrime i =
  let rootI = sqrt $ fromIntegral i
   in and
        [ i `mod` x /= 0
          | x <- [2 .. floor rootI]
        ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = (read :: String -> Int) $ head ls
      xs = map (read :: String -> Int) $ tail ls
   in show (solve xs) ++ "\n"