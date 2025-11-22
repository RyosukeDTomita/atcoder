toString :: Char -> String
toString c = (: []) c -- :を使い、空配列と結合することでCharを文字列に変換する

main :: IO ()
main = do
  let c = 'a'
  print c
  print $ toString c
