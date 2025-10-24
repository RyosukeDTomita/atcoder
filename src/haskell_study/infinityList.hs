main :: IO ()
main = do
  let inifinityList = [0 ..] -- 無限リスト
  print $ take 20 inifinityList -- 必要な数だけ取り出せる。