-- listの例
main :: IO ()
main = do
  let list = [1, 2, 3]
  print list
  let newList = 4 : list -- リストの先頭に要素を1つくっつける
  print newList -- [4,1,2,3] が出力される

  -- スライスの例
  let newList2 = (take 2 list) -- 最初のn個の要素を取得
  print newList2
  let newList3 = (drop 2 list) -- 最初のn個の要素を削除した残り
  print newList3
