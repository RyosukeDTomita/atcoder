import Control.Arrow ((>>>))
import Text.Printf (printf)

distance :: [Double] -> Double
distance [x1, y1, x2, y2] = sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

main :: IO ()
main =
  interact $ \input ->
    let xys = map read $ words input :: [Double]
     in printf "%.08f\n" $ distance xys
