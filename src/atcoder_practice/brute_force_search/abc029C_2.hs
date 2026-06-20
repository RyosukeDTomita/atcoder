-- https://atcoder.jp/contests/abc029/tasks/abc029_c
-- リストモナド強すぎて草
import Control.Arrow ((>>>))
import Control.Monad (replicateM)

solve :: Int -> [String]
solve n = replicateM n "abc"

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> unlines
