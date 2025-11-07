import Control.Arrow ((>>>))

solve :: [Integer] -> Integer
solve [a, b] = abs (a - b)

main :: IO ()
main =
  interact $
    lines >>> map (words >>> map read >>> solve >>> show) >>> unlines