getSquares :: [String] -> Int -> [[String]]
getSquares grid m =
  [ [take m (drop c row) | row <- take m (drop r grid)] -- rowで行を切り出し、その後左側の式で列を取り出している。dropで配列の先頭をr(c)個落としてからtake mすることで全通りの取得を実現できる。
    | r <- [0 .. n - m],
      c <- [0 .. n - m] -- この書き方で二重ループになる
  ]
  where
    n = length grid

-- ｒ=c=0の場合のイメージ(わかりやすさのため、#と.ではなく数字をgridに使っている。)
-- ghci> let grid = ["123", "456", "789"]
-- ghci> [ take 2 (drop 0 row) | row <- take 2 (drop 0 grid)]
-- ["12","45"]
-- ghci> take 2 (drop 0 grid)
-- ["123","456"]
-- ghci> [ take 2 (drop 0 row) | row <- ["123", "456"]]
-- ["12","45"]

main :: IO ()
main = do
  let m = 2
  let grid = ["123", "456", "789"] -- わかりやすさのため、#と.ではなく数字をgridに使っている。)
  print $ getSquares grid m -- [["12","45"],["23","56"],["45","78"],["56","89"]]
