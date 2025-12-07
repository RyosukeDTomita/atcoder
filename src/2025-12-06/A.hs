import Control.Arrow ((>>>))

solve :: Int -> Int
solve n = sum [1 .. n]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")