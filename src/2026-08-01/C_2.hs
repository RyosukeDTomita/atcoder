{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (mapAccumL)
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

solve :: Int -> BS.ByteString -> [Int]
solve n s = snd $ mapAccumL go 0 [1 .. n] -- 累積和のindex=0は0なので1スタートにする。問題的にもkのスタートは1からだし。
  where
    -- 累積和。i番目にそれまでのあたりの数がある。
    prefSum = VU.scanl' (\acc c -> if c == 'o' then acc + 1 else acc) 0 $ VU.generate n (BS.index s)
    go :: Int -> Int -> (Int, Int)
    go acc k
      | n == acc = (n, n)
      | otherwise = (result, result)
      where
        -- k個食べた状態から開始して累積和のk番目を見て、増えてたらその分先にindexを進めることを繰り返す。つまり、累積和のindexの場所が答えになる。
        result = step k (prefSum VU.! k)
    step :: Int -> Int -> Int
    step !pos 0 = pos
    step !pos !stock
      | pos >= n = n
      -- stockが正の数なのでpostionをその分だけ前に進める
      | otherwise = step next (prefSum VU.! next - prefSum VU.! pos)
      where
        next = min n (pos + stock)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        s = ls !! 1
     in BS.unlines $ map (BS.pack . show) (solve n s)
