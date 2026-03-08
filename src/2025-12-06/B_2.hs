solve :: [Int] -> Int -> Int
solve as n =
  length
    -- NOTE: l < rならこっちの書き方をすればl==rのケースを弾かなくて良くなる。
    [ [l, r]
      | l <- [1 .. n],
        r <- [l .. n],
        check l r as
    ]

check :: Int -> Int -> [Int] -> Bool
check l r as =
  let alr =
        -- NOTE: take dropで頑張るよりもこっちのほうが楽そう
        [ as !! i
          | i <- [l .. r]
        ]
      sumAlr = sum alr
   in all (\a -> sumAlr `mod` a /= 0) alr

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = 0 : (map read . words $ ls !! 1) :: [Int] -- Haskellのリストのインデックスは0スタートなので冒頭に0を追加
   in show (solve as n) ++ "\n"
