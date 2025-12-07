solve :: [Int] -> Int -> Int
-- solve :: [Int] -> Int -> [[Int]]
solve as n =
  length
    [ [l, r]
      | r <- [2 .. n],
        l <- [1 .. r],
        l /= r && check l r as
    ]

check :: Int -> Int -> [Int] -> Bool
check l r as =
  let alr = drop l $ take (r + 1) as
      sumAlr = sum alr
   in all (\a -> sumAlr `mod` a /= 0) alr

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = 0 : (map read . words $ ls !! 1) :: [Int] -- Haskellのリストのインデックスは0スタートなので冒頭に0を追加
   in show (solve as n) ++ "\n"

--  in show $ solve as n