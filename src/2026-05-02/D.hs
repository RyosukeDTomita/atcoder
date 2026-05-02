{-# LANGUAGE BangPatterns #-}
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

-- 末尾の文字ごとに「隣接同字でない部分列の個数」をDPで持つ。
-- 現文字 ch を見たとき:
--   dp[ch] ← dp[ch] + 1 + (dp[他の2文字の合計])
--     +1: ch 1文字だけの新しい部分列
--     +他: 末尾が ch 以外で終わる既存部分列に ch を付け足したもの
--     dp[ch] をそのまま残すのは現在位置を取らない既存部分列
solve :: BS.ByteString -> Int
solve s =
  let p = 998244353
      step (!da, !db, !dc) ch = case ch of
        'a' -> ((da + 1 + db + dc) `mod` p, db, dc)
        'b' -> (da, (db + 1 + da + dc) `mod` p, dc)
        'c' -> (da, db, (dc + 1 + da + db) `mod` p)
        _ -> (da, db, dc)
      (a, b, c) = BS.foldl' step (0, 0, 0) s
   in (a + b + c) `mod` p

main :: IO ()
main =
  BS.interact $ \input ->
    let s = BS.init input
     in (BS.pack . show) (solve s) <> BS.pack "\n"
