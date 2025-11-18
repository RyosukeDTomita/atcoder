import Data.Char (digitToInt)

sumDigit :: String -> Int
sumDigit n = sum $ map digitToInt n

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      xs = takeWhile (/= "0") ls
   in unlines $ map (show . sumDigit) xs