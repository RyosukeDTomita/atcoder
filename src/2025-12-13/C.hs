solve :: Int -> Int -> [[Int]] -> [[Int]]
solve n m rcs =
  let xss =
        [ [ 0
            | c <- [0 .. n - 1]
          ]
          | r <- [0 .. n - 1]
        ] -- 一旦0埋めする
   in foldl go xss rcs
  where
    go xss rc
      | null rc = xss -- 終了
      | otherwise =
          [ [ if rc == [r, c] || rc == [r + 1, c] || rc == [r, c + 1] || rc == [r + 1, c + 1] then 1 else 0
              | c <- [0 .. n - 1]
            ]
            | r <- [0 .. n - 1]
          ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map (read :: String -> Int) . words $ head ls
      rcs = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map (unwords . map show) $ solve n m rcs