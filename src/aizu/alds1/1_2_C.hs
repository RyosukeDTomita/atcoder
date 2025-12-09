import Data.List (delete, minimumBy, unfoldr)
import Data.Ord (comparing)

type Card = (Char, Int)

parseCard :: String -> Card
parseCard (suit : num) = (suit, (read :: String -> Int) num)

bubbleSort :: [Card] -> [Card]
bubbleSort xs =
  -- リストの数だけ再帰する
  go xs (length xs)
  where
    go xs 0 = xs
    go xs n = go (bubble xs) (n - 1)

    -- 隣同士を比較して交換する関数
    bubble (x : y : zs)
      | snd x > snd y = y : bubble (x : zs)
      | otherwise = x : bubble (y : zs)
    bubble xs = xs -- リストのサイズが2未満になった時

-- Haskellの場合、swapしないため、selction sortが安定になってしまった。
selectionSort :: [Card] -> [Card]
selectionSort xs = unfoldr go xs
  where
    go [] = Nothing -- 空なら停止
    go xs =
      let m = minimumBy (comparing snd) xs
          xs' = delete m xs
       in Just (m, xs')

showCards :: [Card] -> String
showCards cards = unwords (map (\(suit, num) -> suit : show num) cards)

-- わざと非安定なものを作った。
selectionSort' :: [Card] -> [Card]
selectionSort' xs = go xs 0
  where
    go xs i
      | i >= length xs = xs
      | otherwise =
          let (before, x : after) = splitAt i xs
              j = i + minIndex (x : after)
              (before2, y : after2) = splitAt j xs
              xs' = replace i y (replace j x xs)
           in go xs' (i + 1)

    minIndex ys = snd $ minimumBy (comparing (snd . fst)) (zip ys [0 ..])

    replace i v xs = take i xs ++ [v] ++ drop (i + 1) xs

solve :: [Card] -> String
solve cards =
  let bubbleSortResult = bubbleSort cards
      selectionSortResult = selectionSort' cards
      isSelectionSortIsStable = if bubbleSortResult == selectionSortResult then "Stable" else "Not stable"
   in showCards bubbleSortResult ++ "\n" ++ "Stable" ++ "\n" ++ showCards selectionSortResult ++ "\n" ++ isSelectionSortIsStable ++ "\n"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = (read :: String -> Int) $ head ls
      cards = map parseCard . words $ ls !! 1
   in solve cards