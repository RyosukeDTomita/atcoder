import Control.Arrow ((>>>))

solve :: Double -> Double
solve d = ((d * 0.5) ** 2) * pi

main :: IO ()
main =
  interact $
    (read :: String -> Double) >>> solve >>> show >>> (++ "\n")
