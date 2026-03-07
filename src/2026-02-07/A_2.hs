-- 3桁固定なので楽できる。
import Control.Arrow ((>>>))

solve :: String -> String
solve s =
  let [a, b, c] = take 3 s -- 改行を外す
      result = a == b && b == c
   in if result then "Yes" else "No"

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")
