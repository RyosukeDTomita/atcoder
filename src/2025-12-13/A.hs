solve :: String -> Int -> String
solve s n
  | length s == n = s
  | otherwise = solve ('o' : s) n

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in (solve s n) ++ "\n"