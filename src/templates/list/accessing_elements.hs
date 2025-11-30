import Data.Vector qualified as V

head' :: [a] -> a
head' (x : xs) = x

init' :: [a] -> [a]
init' [x] = []
init' (x : xs) = x : init' xs

tail' :: [a] -> [a]
tail' (_ : xs) = xs

last' :: [a] -> a
last' [x] = x
last' (_ : xs) = last xs

(!!) :: [a] -> Int -> a
[] !! _ = error "index too large"
(x : _) !! 0 = x
(_ : xs) !! n = xs !! (n - 1)

main :: IO ()
main = do
  -- 前提: Haskellの通常のリストは単方向連結リストである。そのため、データの先頭に対する操作はO(1)だが、末尾に対する操作はO(n)
  let xs = [1, 2, 3] -- 内部的には 1 : (2 : 3 : [])
  let v = V.fromList xs -- 配列なのでどの要素にアクセスしてもO(1)
  -- 先頭文字列を取得
  print $ head xs -- O(1) head'参照
  print $ head' xs
  -- 先頭以外を取得
  print $ tail xs -- O(1) tailは実質的には先頭要素を取得しているだけ(tail'参照)
  print $ tail' xs
  -- 末尾以外を取得
  print $ init xs -- O(n) init'参照
  print $ init' xs
  print $ V.slice 0 (V.length v - 1) v -- O(1) NOTE: Data.Vectorは配列ベースなので内部で配列の長さを保持しているため、lengthがO(1)で取得できる。また、リストのようにスライスする際には元の配列を参照するので
  -- 末尾を取得
  print $ last xs -- O(n) -- lastは再帰しないと最後の要素までたどり着かないので遅い(last'参照)
  print $ last' xs
  -- print $ (head . drop (3 - 1)) xs -- O(n-1)なので変わらない(競技プログラミングは配列サイズが与えられていると想定しているためこのように記述しているがlengthを使って配列サイズを求める場合とO(n)がかかるので悪化する)
  print $ V.last v -- O(1)
