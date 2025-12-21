module Nub (nub') where

-- 先頭要素をとりだし、filterするので(n-1) + (n-2) + (n-3) .. 1 = (n^2)/2で遅い
nub' :: (Eq a) => [a] -> [a]
nub' [] = []
nub' (x : xs) = x : nub' (filter (/= x) xs)

main :: IO ()
main = do
  print $ nub' [1, 1, 2, 3, 5, 8] -- nubは遅い(O(n^2)のため非推奨)