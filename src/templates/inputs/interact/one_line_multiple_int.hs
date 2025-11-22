import Control.Arrow ((>>>))

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> map show >>> unwords >>> (++ "\n")
