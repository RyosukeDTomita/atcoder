import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [a, b] = a * 12 + b

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")