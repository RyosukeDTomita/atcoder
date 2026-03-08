import Data.List ((\\))

toTuple :: [String] -> (Char, Int)
toTuple [suit, rank] = (head suit, read rank)

solve :: [(Char, Int)] -> String
solve cards = unlines $ map (\(s, n) -> s : ' ' : show n) $ findMissingCard cards

findMissingCard :: [(Char, Int)] -> [(Char, Int)]
findMissingCard cards =
  let fullDeck =
        [ (s, n)
          | s <- "SHCD",
            n <- [1 .. 13]
        ]
   in fullDeck \\ cards -- \\はリストの差を求める演算子

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      _ = read $ head ls :: Int
      cards = map (toTuple . words) $ tail ls
   in solve cards
