-- トップレベル束縛はファイル全体で有効
a = 1

f :: Int -> Int
f x = y + x
  where
    y = 3 -- where束縛は関数の中でのみ有効

g :: Int -> Int
g x =
  let y = 3 -- let束縛は式の中でのみ有効
    in y + x


main :: IO()
main = do
  print a
  let b = 2 -- 特別なlet束縛(in不要)
  print b
  print (f 1)
  print (g 1)
  -- print(y) アクセスできない
