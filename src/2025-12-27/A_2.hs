-- 無駄な分岐があったので省いた
import Control.Arrow ((>>>))

solve :: [Int] -> Int
solve [d, f] =
  let result = f - (d `mod` 7)
   in if result <= 0 then result + 7 else result

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")