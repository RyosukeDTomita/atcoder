solve :: Int -> Int -> Int -> Int -> String
solve p q x y = if (p <= x) && (x <= (p + 99)) && (q <= y) && (y <= (q + 99)) then "Yes" else "No"

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [p, q] = map read . words $ head ls :: [Int]
        [x, y] = map read . words $ ls !! 1 :: [Int]
     in solve p q x y ++ "\n"