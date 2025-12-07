solve :: [Int] -> Int
solve as = go 0 0 as
  where
    -- pos: 現在の位置(0-indexed), reach: 現在到達可能な最大位置
    go pos reach [] = pos -- 全て倒しきった場合には今まで倒したドミノの数を返す
    go pos reach (a : rest)
      | pos > reach = pos -- 現在位置が到達範囲を超えたら終了 NOTE: pos > reachになるのは理論的に矛盾している気がするが更新前であるため気にしない。
      | otherwise = go (pos + 1) (max reach (pos + a - 1)) rest -- NOTE: A_i == 1の時にはこれ以上ドミノは倒れないのが正しいため、a-1している。

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
   in show (solve as) ++ "\n"