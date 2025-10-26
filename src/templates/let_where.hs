fwhere :: Int -> Int
fwhere x = y + x
  where
    y = 1 -- where束縛は関数の中でのみ有効

flet :: Int -> Int
flet x =
  let y = 2 -- let束縛は式の中でのみ有効
   in y + x

main :: IO ()
main = do
  let b = 2 -- 特別なlet束縛(in不要)
  print b
  print (fwhere 1)
  print (flet 1)

-- print(y) アクセスできない
