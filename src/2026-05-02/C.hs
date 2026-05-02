-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
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

-- 同じ文字が隣り合った場所があったらそこで区切る
-- 例: "aabc" -> ["a", "abc"]
split :: BS.ByteString -> [BS.ByteString]
split bs
  | BS.null bs = []
  | otherwise =
      let (chunk, rest) = BS.splitAt (findSplit 1) bs
       in chunk : split rest
  where
    n = BS.length bs
    findSplit i
      | i >= n = n
      | BS.index bs i == BS.index bs (i - 1) = i
      | otherwise = findSplit (i + 1)

-- NOTE: 問題分の制約により、取り出す位置が異なるならば、文字列として同じものでも区別する。
-- NOTE: 部分列はもとの文字列の長さをLとした時に L + L-1 + L-2 ... 1で求められるのは、開始位置iの時L-i個の部分列が存在するから。
solve :: BS.ByteString -> Int
solve s =
  let p = 998244353
      -- 各チャンク (同じ文字が隣り合わない極大区間) 内の連続部分文字列の個数 = L*(L+1)/2
      countChunk c =
        let l = BS.length c
         in l * (l + 1) `div` 2
   in sum (map countChunk (split s)) `mod` p

main :: IO ()
main =
  BS.interact $ \input ->
    let s = BS.init input
     in (BS.pack . show) (solve s) <> BS.pack "\n"
