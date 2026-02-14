import Control.Arrow ((>>>))

solve :: String -> String
solve s =
  let s' = filter (/= '\n') s
   in if head s' == last s' then "Yes" else "No"

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")