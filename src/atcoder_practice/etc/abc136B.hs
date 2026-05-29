import Control.Arrow ((>>>))
import Data.Vector.Unboxed qualified as VU

-- solve :: Int -> Int
-- solve n = length $ filter (odd . length . show) [1 .. n]

-- Vector版
solve :: Int -> Int
solve n = VU.length $ VU.filter (odd . length . show) $ VU.enumFromN (1 :: Int) n

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
