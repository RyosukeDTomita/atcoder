-- elem使ったほうがきれい
import Control.Arrow ((>>>))

solve :: String -> Int
solve s = length $ filter (`elem` "ij") s

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")