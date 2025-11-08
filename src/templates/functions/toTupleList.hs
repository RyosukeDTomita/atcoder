toTuple :: [String] -> (Char, Int)
toTuple [suit, rank] =
  (head suit, read rank :: Int)

main :: IO ()
main = do
  let cards = [["A", "3"], ["H", "1"], ["D", "10"], ["C", "4"]] -- トランプのカード
  print $ map toTuple cards -- [('A',3),('H',1),('D',10),('C',4)]