solve :: Int -> Int -> [Int] -> Int
solve l k as = binarySearch 0 l (canCut l k as)

-- スコアがx以上になる切れ端を作れるかを判定する
canCut :: Int -> Int -> [Int] -> Int -> Bool
canCut l k as x = go 0 0 as -- 現在の切れ端の個数と直前に切った場所の位置という状態を管理するためにローカル関数を使う
  where
    -- 切れ目を入れてチェックする
    go cnt last (a : rest)
      | a - last >= x -- 新しく切る切れ端がx以上のサイズか
        =
          ((cnt + 1 == k) && (l - a >= x)) || go (cnt + 1) a rest -- 今回で切る回数が充分なら残りの切れ端が条件を満たすか確認する。そうでないなら切る回数と最後に切った場所を更新して再帰
      | otherwise = go cnt last rest -- 次の切れ目を試す
    go _ _ [] = False

-- fがTrueを返す最大の値xを二分探索で求める
binarySearch :: Int -> Int -> (Int -> Bool) -> Int
binarySearch ok ng f
  | abs (ok - ng) <= 1 = ok -- fがTrueを返す最大の値x
  | f mid = binarySearch mid ng f
  | otherwise = binarySearch ok mid f
  where
    mid = (ok + ng) `div` 2

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, l] = map read . words $ head ls :: [Int] -- 切れ端の数,羊羹の長さ
      k = read $ ls !! 1 :: Int
      as = map read . words $ ls !! 2 :: [Int]
   in show (solve l k as) ++ "\n"