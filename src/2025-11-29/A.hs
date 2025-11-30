import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [w, b] = w * 1000 `div` b + 1

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")