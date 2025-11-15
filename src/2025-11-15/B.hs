import Data.Char (digitToInt)
import Data.List (elemIndex, sort)
import Data.Maybe (fromMaybe)

-- 0から始まる数はないので、sort後に0が混じっていたら次に小さい数を先頭に出して残りをつなげる。
solve :: Int -> [Int]
solve x =
  if 0 `elem` sortX
    then
      drop i (take (i + 1) sortX) ++ replicate zeroN 0 ++ drop (zeroN + 1) sortX
    else sortX
  where
    sortX = sort $ map digitToInt $ show x
    minNotZero = minimum $ filter (> 0) sortX
    i = fromMaybe (-1) (elemIndex minNotZero sortX)
    zeroN = length $ filter (== 0) sortX

main :: IO ()
main =
  interact $ \inputs ->
    let x = read $ inputs :: Int
     in concatMap show (solve x) ++ "\n"