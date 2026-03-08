import Text.Printf (printf)

-- 標準偏差を求める関数
stdDev :: [Double] -> Double
stdDev xs =
  let n = fromIntegral (length xs) :: Double -- Doubleに型変換
      mean = sum xs / n
      variance =
        sum
          [ (x - mean) ^ 2
            | x <- xs
          ]
          / n
   in sqrt variance

solve :: [String] -> [Double]
solve ["0"] = [] -- 終了
solve
  (ss : rest) =
    let scores = map read (words (head rest)) :: [Double]
        sd = stdDev scores
     in sd : solve (tail rest)

main :: IO ()
main =
  interact $ \input ->
    let results = solve $ lines input
     in unlines $ map (printf "%.8f") results
