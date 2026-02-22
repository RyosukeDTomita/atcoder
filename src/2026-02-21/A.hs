import Data.Char (toLower)

solve :: String -> String
solve s = "Of" ++ map toLower s

main :: IO ()
main =
  interact solve