{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
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

-- A以外の文字ごとに区切ったAの個数リストを作る。
-- Aが出たらaccをインクリメント、A以外が出たらaccを配列に追加してリセットする
-- "ABC"  -> [1, 0, 0]
-- "BACA" -> [0, 1, 1]
countAGaps :: String -> [Int]
countAGaps s = go 0 s
  where
    go acc [] = [acc]
    go acc (c : cs)
      | c == 'A' = go (acc + 1) cs
      | otherwise = acc : go 0 cs

cal :: String -> String -> Int
cal s t = sum $ zipWith (\a b -> abs (a - b)) (countAGaps s) (countAGaps t)

solve :: ByteString -> ByteString -> Int
solve s t =
  let sFilterNotA = BS.filter (/= 'A') s
      tFilterNotA = BS.filter (/= 'A') t
   in if sFilterNotA /= tFilterNotA then -1 else cal (BS.unpack s) (BS.unpack t)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let [s, t] = BS.lines inputs
     in (BS.pack . show) (solve s t) <> BS.pack "\n"
