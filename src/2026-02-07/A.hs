import Control.Arrow ((>>>))

solve :: String -> String
solve n = go (head n) (init n) -- initで改行を外す
  where
    go x [] = "Yes"
    go x (y : rest)
      | x == y = go x rest
      | otherwise = "No"

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
