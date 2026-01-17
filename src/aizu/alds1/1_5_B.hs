{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
-- import Data.ByteString.Char8 qualified as BS
import Data.ByteString.Char8 qualified as BS -- AOJ
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

solve :: [Int] -> ([Int], Int)
solve ss = mergeSort ss

mergeSort :: [Int] -> ([Int], Int)
mergeSort [] = ([], 0)
mergeSort [x] = ([x], 0)
mergeSort xs =
  let (left, right) = splitAt (length xs `div` 2) xs
      (sortedLeft, countL) = mergeSort left
      (sortedRight, countR) = mergeSort right
      (merged, countM) = merge sortedLeft sortedRight
   in (merged, countL + countR + countM)

-- 配列を合成する過程でソートする
merge :: [Int] -> [Int] -> ([Int], Int)
merge [] ys = (ys, 0)
merge xs [] = (xs, 0)
merge (x : xs) (y : ys)
  | x <= y =
      let (rest, cnt) = merge xs (y : ys)
       in (x : rest, cnt)
  | otherwise =
      let (rest, cnt) = merge (x : xs) ys
       in (y : rest, cnt + 1 + length xs)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        ss = map readInt . BS.words $ ls !! 1 :: [Int]
        (result, count) = solve ss
     in BS.unwords (map (BS.pack . show) result) <> BS.pack "\n" <> BS.pack (show count) <> BS.pack "\n"