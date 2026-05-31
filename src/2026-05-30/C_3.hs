-- C_2.hs を mapAccumL で書き換えた版
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (mapAccumL, sort)
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

-- as シャリ
-- bs ネタ
-- 状態 = 残りシャリ、出力 = ネタごとに載せられたら 1 / 無理なら 0。最後に sum でカウント。
solve :: [Int] -> [Int] -> Int
solve as bs = sum res -- 状態更新と答えを出す過程を分離している
  where
    (_, res) = mapAccumL go as' bs'
    -- ネタ y に載せられないシャリ (2*x < y) を読み飛ばし、最初に足りるシャリを1個消費する貪欲法。
    go :: [Int] -> Int -> ([Int], Int)
    go shari y =
      case dropWhile (\x -> 2 * x < y) shari of
        (_ : rest) -> (rest, 1) -- シャリにネタを載せられたら1
        [] -> ([], 0)
    !as' = dbgId $ sort as
    !bs' = dbgId $ sort bs

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, m] = map readInt . BS.words $ head ls :: [Int]
        as = map readInt . BS.words $ ls !! 1 :: [Int]
        bs = map readInt . BS.words $ ls !! 2 :: [Int]
     in (BS.pack . show) (solve as bs) <> BS.pack "\n"
