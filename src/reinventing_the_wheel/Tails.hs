module Tails (tails') where

-- 現在のリストに先頭を一つとったリストを連結するだけ
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' xs@(_ : rest) = xs : tails' rest

main :: IO ()
main = do
  print $ tails' "abc"