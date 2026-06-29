import Data.Array -- Haskellの他の関数と名前がかぶらないのでqualified importしない

main :: IO ()
main = do
  let arr1 = listArray (0, 4) [10, 20, 30, 40, 50] -- インデックス 0~4を事前に指定することでランダムアクセスO(1)を実現している。事前に指定したindexの範囲と異なるサイズのリストは使えない
  print arr1 -- array (0,4) [(0,10),(1,20),(2,30),(3,40),(4,50)]
  print $ arr1 ! 1 -- 20
  print $ bounds arr1 -- (0,4)範囲
  print $ inRange (bounds arr1) 2 -- True
  print $ indices arr1 -- [0,1,2,3,4] インデックスのリスト
  print $ elems arr1 -- [10,20,30,40,50] -- リストに変換
  print $ assocs arr1 -- [(0,10),(1,20),(2,30),(3,40),(4,50)] -- tupleのリストに戻す
  -- 一部更新
  let arr2 = arr1 // [(1, 200), (2, 300)]
  print arr2
  -- accumArrayはindexごとに値を畳み込む　最初初期値e(この場合は0)で埋めたarrayを作り、そこに累積する
  let acc = accumArray (+) 0 (0, 2) [(0, 10), (1, 20), (2, 30), (0, 1), (1, 2), (2, 3)] -- array (0,2) [(0,11),(1,22),(2,33)]
  print acc
  -- accumは既存の配列に対して畳み込みする
  let acc2 = accum (+) (listArray (0, 2) [10, 20, 30]) [(0, 1), (1, 2), (2, 3)] -- array (0,2) [(0,11),(1,22),(2,33)]
  print acc2
  -- ジャグ配列(隣接リスト)はVectorよりも扱いやすい
  let jag = listArray (0, 2) [[1, 2, 3], [10, 20, 30], [100, 200]] -- array (0,2) [(0,[1,2,3]),(1,[10,20,30]),(2,[100,200])]
  print jag

  -- 2次元配列: タプル(Int,Int)もIxインスタンスなのでそのまま添字にできる(i*w+jの手計算が不要)
  let h = 3
      w = 4
      grid = listArray ((0, 0), (h - 1, w - 1)) "s..#.....#.g" -- 添字(i,j)=(行,列)。行を連結した文字列を流し込む(row0="s..#",row1="....",row2=".#.g")
  print grid -- array ((0,0),(2,3)) [((0,0),'s'),((0,1),'.'),...,((2,1),'#'),...,((2,3),'g')]
  print $ grid ! (0, 0) -- 's'  座標(i,j)でO(1)アクセス
  -- 2次元Listの2次元Array変換
  let matrix = listArray ((0, 0), (h - 1, w - 1)) $ concat [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
  print matrix
