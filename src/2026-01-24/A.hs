import Control.Arrow ((>>>))

solve :: String -> Int
solve s = length $ filter (\c -> c == 'i' || c == 'j') s

main :: IO ()
main =
  interact $
    solve >>> show >>> (++ "\n")
