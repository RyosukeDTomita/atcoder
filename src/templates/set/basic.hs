import Data.Maybe (fromJust)
import Data.Set qualified as Set

main :: IO ()
main = do
  let xs = [1, 2, 3]
  print xs
  let xSet = Set.fromList xs
  print xSet
  let ascList = Set.toList xSet -- リストに戻す。並行２分探索木なのでソート済みになる。toAscListやelemsは基本的にtoListのエイリアスなのでどれを使っても良い。
  print ascList
  let dscList = Set.toDescList xSet -- リスト逆順でに戻す。listにしてからreverseするよりも効率が良い
  print dscList
  let xSet' = Set.insert 10 xSet
  print xSet'
  let xSet'' = Set.delete 10 xSet
  print xSet''
  print $ 2 `Set.member` xSet
  print $ 4 `Set.member` xSet
  print $ fromJust $ Set.lookupLT 6 $ Set.fromList [2, 4, 6, 8] -- 6未満で最大は4
  print $ fromJust $ Set.lookupGT 6 $ Set.fromList [2, 4, 6, 8] -- 6より大きく最小は8
  print $ fromJust $ Set.lookupLE 6 $ Set.fromList [2, 4, 6, 8] -- 6自身も含む最小は6
  print $ fromJust $ Set.lookupGE 6 $ Set.fromList [2, 4, 6, 8] -- 6自身も含む最小は6
  print $ Set.findMin $ Set.fromList [2, 4, 6, 8] -- 2
  print $ Set.findMax $ Set.fromList [2, 4, 6, 8] -- 8
  print $ Set.elemAt 2 $ Set.fromList [8, 2, 6, 4] -- 内部的にはソートされているので6 O(log n)
  print $ fromJust $ Set.lookupIndex 6 $ Set.fromList [8, 2, 6, 4] -- 内部的にはソートされているので2
  print $ Set.findIndex 6 $ Set.fromList [8, 2, 6, 4] -- 内部的にはソートされているので2
