-- x=小さい飴の重さ
-- y=大きい飴の重さ
-- 各子供に配る飴の数=as
-- 子供iに小さい飴をs_i個、大きい飴をl_i個配るとs_i + l_i = a、x * s_i + y + l_i = sumCandyW(総重量)
-- これを変形すると(y - x) * l_i = sumCandyW - x * a
-- つまり、sumCandyW - x * aが(y - x)の倍数である必要がある。 --> そうでない場合は解なしで-1を出力
-- (sumCandyW - x * a) `mod` (y - x) == 0となるので
-- sumCandyW ≡ a * x (mod 'y-x))
-- まず、これを用いて適切でないaが存在するケースを弾く。
--
-- 大きい飴が1つ増えると総重量は(y - x)重くなるため、各aに対して a * x <= sumCandyW <= a * yの範囲を取る。
-- 全てのiでこの区間を取ると、sumCandyWが存在する範囲はこの共通部分になる。
-- a=minAs の区間：     [minAs*x -------------------- minAs*y]
-- a=maxAs の区間：                      [maxAs*x -------------------- maxAs*y]
-- これを満たさないのは共通範囲なし、つまりminAs * y < x * maxAs
-- これを用いて、共通部分となるWが存在しないケースを弾く
solve :: (Int, Int) -> [Int] -> Int
solve (x, y) as
  | any (\a -> (a * x) `mod` subYX /= targetMod) as = -1 -- anyは一つでも一致したらTrueを返すので、条件を満たさないA_iがある場合には-1を返す。
  | y * minAs < x * maxAs = -1
  -- 最後にsumCandyWの値を絞り込む。
  -- 先程の数直線をみると、sumCandyWの最大値はminAs * yであることがわかる。
  -- すべてのaに対してsumCandyWの値を統一できる必要があるため、(y - x)刻みで値を取る。
  -- 最初の入力値チェックにより、すべてのaに対してa * x `mod` (y - x)の値が等しいことがわかる。そのため、sumCandyW `mod` (y - x) == targetModを満たす必要がある。
  -- ここで、sumCandyWの最大値である、minAs * y `mod` (y - x)をrと置くと、r == targetModの場合には、sumCandyWは条件を満たす。
  -- r != targetModの場合、sumCandyW `mod` (y - x)をtargetModに合わせるために、r - targetModを(y - x)で正規化した値 = sumCandyW - targetMod + (y - x) `mod` (y - x)だけずらせばよい。
  -- (sumCandyW ≡ targetMod + z (mod (y - x))を満たすzの値を求める計算になる)
  -- NOTE: プログラミングの場合負の数のmodは負の値になるため、正になるように(y - x)を足しておくと安心。
  -- -4 `mod` 7
  -- -4
  -- ghci> -4 `mod` 7 + 7
  -- 3
  | otherwise =
      let sumCandyW = minAs * y - ((minAs * y `mod` subYX - targetMod + subYX) `mod` subYX)
       in sum [(sumCandyW - a * x) `div` subYX | a <- as]
  where
    subYX = y - x
    targetMod = (head as * x) `mod` subYX -- すべてのaに対してmod subYXは等しいはずなので、最初のasを基準にしてそれと等しいかを調べる。
    minAs = minimum as
    maxAs = maximum as

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, x, y] = map read . words $ head ls :: [Int]
      as = map read . words $ ls !! 1 :: [Int]
   in show (solve (x, y) as) ++ "\n"
