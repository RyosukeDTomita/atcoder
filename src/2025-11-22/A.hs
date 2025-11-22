-- 条件を読み間違えたやつ。初期状態でx >= 100、y >= 100なだけで、その後の制限はない。
import Control.Arrow ((>>>))

solve :: [Double] -> String
solve [x, y, z]
  | x >= 100 = "No"
  | y >= 100 = "No"
  | x / y == z = "Yes"
  | otherwise = solve [x + 1, y + 1, z]

main :: IO ()
main =
  interact $
    words
      >>> map (read :: String -> Double)
      >>> solve
      >>> (++ "\n")
