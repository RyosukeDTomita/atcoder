-- https://atcoder.jp/contests/abc136/tasks/abc136_b
import Control.Arrow ((>>>))

solve :: Int -> Int
-- solve n = length $ filter (odd . length) $ map show [1 .. n]
-- 全部関数合成にしたほうが効率が良さそう
solve n = length $ filter (odd . length . show) [1 .. n]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
