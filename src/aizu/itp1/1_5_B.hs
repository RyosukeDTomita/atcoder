-- 以下のような辺以外が.になった図形を作成する
-- ###
-- #.#
-- ###
frame :: Int -> Int -> [String]
frame h w =
  let top = replicate w '#'
      mid = "#" ++ replicate (w - 2) '.' ++ "#"
   in top : replicate (h - 2) mid ++ [top]

main :: IO ()
main = do
  h_wList <- map (map read . words) . lines <$> getContents :: IO [[Int]]
  mapM_
    ( \[h, w] ->
        if [h, w] /= [0, 0]
          then do
            putStrLn $ unlines $ frame h w -- unlinesで改行が付与された状態でputStrLnを使うので改行が２つ入る。
          else return ()
    )
    h_wList