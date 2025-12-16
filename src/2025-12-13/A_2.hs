-- replicateを使ったパターン
solve :: String -> Int -> String
solve s n = replicate (n - length s) 'o' ++ s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in (solve s n) ++ "\n"