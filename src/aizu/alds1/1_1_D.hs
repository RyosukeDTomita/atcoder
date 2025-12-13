-- Memory Limit Exceededになったので失敗
solve :: [Int] -> Int
solve rs =
  maximum
    [ (rs !! j) - (rs !! i)
      | i <- [0 .. length rs - 1],
        j <- [i .. length rs - 1],
        i /= j
    ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      rs = map (read :: String -> Int) $ tail ls
   in show (solve rs) ++ "\n"