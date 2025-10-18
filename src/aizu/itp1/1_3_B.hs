main :: IO ()
main = do
  -- 縦列の入力を取得する
  -- 1
  -- 2
  -- 3
  -- 0 (終了の合図)
  input <- getContents -- すべての入力を取得
  let numbers = map read . lines $ input :: [Int] -- linesで改行区切りの文字列をリストに変換する
  let xList = takeWhile (/= 0) numbers -- inputは0で終わり、採集出力に含めなくて良いと問題文で記載されているので0が出るまでnumbersから要素を取得する
  mapM_ (\(i, x) -> putStrLn $ "Case " ++ show i ++ ": " ++ show x) (zip [1 ..] xList) -- zipを使ってCase: iの出力に使うリストのインデックスを取得している。
  -- ghci> xList = [3, 5, 1]
  -- ghci> zip [1..] xList
  -- [(1,3),(2,5),(3,1)]
