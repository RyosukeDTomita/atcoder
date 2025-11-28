import Control.Arrow ((>>>))
import Text.Printf (printf)

solve [a, b, c] = [(area a b c), (perimeter a b c), (calH b c)]

solve :: [Double] -> [Double]
area :: Double -> Double -> Double -> Double
area a b c = a * b * sin (c * pi / 180) * 0.5

perimeter :: Double -> Double -> Double -> Double
perimeter a b c = a + b + sqrt (a ^ 2 + b ^ 2 - 2 * a * b * cos (c * pi / 180))

calH :: Double -> Double -> Double
calH b c = b * sin (c * pi / 180)

main :: IO ()
main =
  interact $ \input ->
    let [a, b, c] = map read $ words input :: [Double]
        results = solve [a, b, c]
     in unlines $ map (printf "%.08f") results
