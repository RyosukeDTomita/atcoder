-- https://atcoder.jp/contests/abc435/submissions/71487470 を参考に作成
solve :: Int -> [(Int, Int)] -> Int
-- reach: 倒れるかの検証を行う右端のindex
-- (pos, a): (現在のindex, A_i)
solve _ [] = 0 -- すべて倒しきったら終了
solve reach ((pos, a) : rest)
  | pos < reach = 1 + solve (max reach (pos + a)) rest -- 現在の位置が到達可能な場所よりも小さいなら再帰。この際に、reachを更新している。
  | otherwise = 0 -- 終了
  -- e.g. as = [3,1,4,1]の場合
  -- solve 2 [(1,3),(2,1),(3,4),(4,1)]
  -- = solve 2 (1, 3) : [(2,1),(3,4),(4,1)]
  -- pos = 1 < reach = 2より
  -- = 1 + solve (max 2 (1+3)) [(2,1),(3,4),(4,1)]
  -- = 1 + solve 4 [(2,1),(3,4),(4,1)]
  -- = 1 + solve 4 (2,1) : [(3,4),(4,1)]
  -- pos = 2 < reach = 4より
  -- = 1 + 1 + solve (max 4 (2+1)) [(3,4),(4,1)]
  -- = 1 + 1 + solve 4 [(3,4),(4,1)]
  -- = 1 + 1 + solve 4 (3,4) : [(4,1)]
  -- pos = 3 < reach = 4より
  -- = 1 + 1 + 1 + solve (max 4 (3+4)) [(4,1)]
  -- = 1 + 1 + 1 + solve 7 (4,1) : []
  -- pos = 4 < reach = 7より
  -- = 1 + 1 + 1 + 1 + solve (max 7 (4+1)) []
  -- = 1 + 1 + 1 + 1 + 0
  -- = 4

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
   in show (solve 2 (zip [1 ..] as)) ++ "\n" -- NOTE: indexをそろえるためにzipを使って再番している。検証開始位置を2からスタートにしている。

-- zip [1..] ['a','b','c']
-- [(1,'a'),(2,'b'),(3,'c')]