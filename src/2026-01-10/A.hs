import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [x, y] = x * (2 ^ y)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")