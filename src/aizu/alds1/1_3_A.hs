import Control.Arrow ((>>>))

solve :: [String] -> [Int]
solve input = foldl step [] input
  where
    step :: [Int] -> String -> [Int]
    step stack operand =
      case operand of
        "+" -> let (a : b : rest) = stack in (b + a) : rest
        "-" -> let (a : b : rest) = stack in (b - a) : rest
        "*" -> let (a : b : rest) = stack in (b * a) : rest
        n -> (read :: String -> Int) n : stack

main :: IO ()
main =
  interact $
    words >>> solve >>> head >>> show >>> (++ "\n")