removeAt :: Int -> [a] -> [a]
-- takeで先頭からi個dropでi番目以降を飛ばしている
removeAt i xs = take i xs ++ drop (i + 1) xs

main :: IO ()
main = do
  s <- getLine
  -- 文字数をカウントして、真ん中の文字を見つける
  let len = length s
  let centerIdx = (len + 1) `div` 2 -- 中置きするためにバッククォートで囲む

  -- 真ん中の文字を削除して出力する
  putStrLn (removeAt (centerIdx - 1) s) -- printにすると"ABDE"のように`"`が含まれて出力されてしまい、WAになる。