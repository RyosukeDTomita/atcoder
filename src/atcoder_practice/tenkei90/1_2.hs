-- https://atcoder.jp/contests/typical90/submissions/49417275 を参考に再実装
solve :: Int -> Int -> [Int] -> Int
solve l k as =
  let as' = as ++ [l]
      ds = zipWith (-) as' $ 0 : as' -- 前の切れ目から現在の切れ目までの距離のリストに変換
      k' = k + 1 -- NOTE: 作るピースの数なのでk + 1
   in binarySearch 0 l (cut k' ds)

-- ちょうどk+1個のピースを作成した際にできる最小ピースがx以上ならtrue
cut :: Int -> [Int] -> Int -> Bool
cut k ds x = x <= minimum (go k ds x 0) -- NOTE: このminimumとxの比較で自動的に決まった最後のピースのサイズ判定が行われている。
  where
    -- ピースの最小値候補になるリスト
    go k [] _ currentPeace
      | k <= 0 = [] -- 切り終わり
      | k == 1 = [currentPeace] -- 最後のピースを自動的に候補に追加
      | otherwise = [-1] -- 切り足りていない
    go k allAs@(a : as) x currentPeace
      -- x以上になる場所なら切って最小値候補のリストに追加
      | x <= currentPeace = currentPeace : go (k - 1) allAs x 0 -- NOTE: aはまだ使っていないのでallAsで再帰している。
      | otherwise = go k as x (currentPeace + a) -- 現在のピースが長さ不足なら次の切れ目も追加して再帰

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