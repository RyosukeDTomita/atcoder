checkPattern :: Int -> Int -> [String]
checkPattern h w =
  let row1 = take w (cycle "#.") -- cycleで無限リストを作成して必要な分を取り出す。
      row2 = take w (cycle ".#")
   in -- リスト内包表記を使い、偶数奇数で模様を切り替える。
      [ if even r
          then row1
          else row2
        | r <- [0 .. h - 1]
      ]

main :: IO ()
main = do
  h_wList <- map (map read . words) . lines <$> getContents :: IO [[Int]]
  mapM_
    ( \[h, w] ->
        if [h, w] /= [0, 0]
          then do
            putStrLn $ unlines (checkPattern h w) -- unlinesで改行が付与された状態でputStrLnを使うので改行が２つ入る。
          else return ()
    )
    h_wList