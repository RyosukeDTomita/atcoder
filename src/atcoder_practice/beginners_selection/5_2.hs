import Control.Arrow ((>>>))
import Control.Monad (guard)

-- 内包表記をリストモナドにする
solve :: [Int] -> Int
solve [a, b, c, x] =
  length $ do
    aN <- [0 .. (min (x `div` 500) a)]
    bN <- [0 .. (min (x `div` 100) b)]
    cN <- [0 .. (min (x `div` 50) c)]
    guard ((aN * 500 + bN * 100 + cN * 50) == x)
    return (aN, bN, cN)

main :: IO ()
main =
  interact $
    lines >>> map read >>> solve >>> show >>> (++ "\n")
