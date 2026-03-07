import Control.Arrow ((>>>))

solve :: [Int] -> String
solve [n, m] = if ((n + 1) `div` 2) >= m then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")
