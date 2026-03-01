import Control.Arrow ((>>>))

solve :: [Int] -> String
solve [n, m] = if (2 * m - 1) <= n then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")