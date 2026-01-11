{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.List (sort)
import Data.Vector qualified as V
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- s(X以上の最小のAのIndex)を探す
lowerBound :: Int -> V.Vector Int -> Int
lowerBound x as = go 0 (V.length as)
  where
    go left right
      | left >= right = left
      | otherwise =
          let middle = (left + right) `div` 2
           in if as V.! middle < x
                then
                  go (middle + 1) right
                else
                  go left middle

-- 二分探索でtrを探す
binarySearch :: Int -> Int -> Int -> V.Vector Int -> Int
binarySearch x y s as = go 0 (V.length as)
  where
    go left right
      | left >= right = left
      | otherwise =
          let middle = (left + right) `div` 2
           in if (as V.! middle - x + 1) - (middle - s + 1) >= y
                then
                  go left middle
                else
                  go (middle + 1) right

-- Aをまずソートする
-- Aにある値のうちX以上である最小の値をAsとする
-- s <= t <= N + 1においてX以上、A_t以下の総数はA_t - X + 1個、このうちAに含まれるものはt - s + 1個あるので
-- X以上、A_t以下の整数でAに含まれないものは(A_t - x + 1) - (t - s + 1)個ある。
-- この個数はtが増えるごとに増加するので、これが > Y、<=Yとなるtr-1、trがわかれば問題の答えはA_tr-1からA_trの間にあることがわかる。
-- この時、X以上、ans以下の整数のうちAに含まれるものの個数はtr - s + 1 -1 = tr -s
-- そのため、ansは X + (Y - 1) + tr -s。NOTE: XからY-1個進めばY個目になるが、Aに含まれるものはその分余計にインクリメントしないといけない。
solve :: [Int] -> [[Int]] -> [Int]
solve as xyS = map solveCase xyS
  where
    asSortedV = V.fromList (sort as)
    solveCase [x, y] =
      let s = lowerBound x asSortedV
          tr = binarySearch x y s asSortedV
          ans = x + (y - 1) + (tr - s)
       in ans

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, q] = map readInt . BS.words $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
        xyS = map (map readInt . BS.words) $ drop 2 $ ls :: [[Int]]
     in BS.unlines (map (BS.pack . show) (solve as xyS))