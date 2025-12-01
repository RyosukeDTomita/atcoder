-- AC後にsolveの実装をエレガントにした例
solve :: [[Int]] -> Bool
solve (a : b : rest) = isReach a b && solve (b : rest) -- Haskellの&&は短絡評価(lazy evaluation)で動くため、isReachがFalseを返した場合には右側は評価されない。
solve _ = True

-- t_nからt_(n+1)に到達可能かを求める。
isReach :: [Int] -> [Int] -> Bool
isReach [tStart, xStart, yStart] [tGoal, xGoal, yGoal] =
  let minT = distance [xStart, yStart] [xGoal, yGoal] -- 最低限移動が必要な回数
      target = (tGoal - tStart) - minT -- 問題の与える時間(回数)と最低限必要な移動回数を比較する
   in if target < 0 then False else target `mod` 2 == 0 -- targetの値が偶数なら到着後に行って戻ってを繰り返せば到達可能。

-- 最低限移動が必要な距離(回数を求める)
distance :: [Int] -> [Int] -> Int
distance [xStart, yStart] [xGoal, yGoal] = abs (xGoal - xStart) + abs (yGoal - yStart)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      plans = map (map read . words) $ tail ls :: [[Int]]
      plans' = [0, 0, 0] : plans -- 初期値を追加
   in if solve plans' then "Yes\n" else "No\n"