import Text.Printf (printf)

solve :: [Double] -> [Double] -> [Double]
solve xs ys = foldl (\acc p -> acc ++ [distance xs ys p]) [] [1, 2, 3, 8] -- foldlの第一、第二引数は固定にして第三引数だけを変えて折りたたむ

distance :: [Double] -> [Double] -> Int -> Double
distance xs ys p
  | p == 8 =
      maximum
        [ abs (xs !! i - ys !! i)
          | i <- [0 .. length xs - 1]
        ]
  | otherwise =
      let tmp =
            sum $
              [ abs $ (xs !! i - ys !! i) ^ p
                | i <- [0 .. length xs - 1]
              ]
       in tmp ** (1 / fromIntegral p)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = map read . words $ ls !! 1 :: [Double]
      ys = map read . words $ ls !! 2 :: [Double]
   in unlines $ map (printf "%.8f") $ solve xs ys