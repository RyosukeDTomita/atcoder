-- frequnencyでクソデカVectorを格納しようとしてエラーになった。
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (sort)
import Data.Vector.Unboxed qualified as VU
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

-- i番目にiが何個Listに存在するかを持つデータVector
frequency :: Int -> [Int] -> VU.Vector Int
-- NOTE: accumulateは第2引数に初期ベクタ、第3引数の(index番号, value)をとり、f valueを初期ベクタのn番目に適用する関数である。
frequency maxX xs = VU.accumulate (+) (VU.replicate (maxX + 1) 0) (VU.fromList [(x, 1) | x <- xs])

-- NOTE: imapはインデックスiと値xの両方を受け取って変換できる。
solve :: Int -> Int -> [Int] -> Int
solve n k aList =
  let !aMap = frequency (maximum aList) aList
      !sorted = sort $ VU.toList $ VU.imap (*) aMap
   in sum $ take (VU.length aMap - k) sorted

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, k] = map readInt . BS.words $ head ls :: [Int]
        aList = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve n k aList) <> BS.pack "\n"
