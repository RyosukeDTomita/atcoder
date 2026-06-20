-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (transpose)
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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- | hlsの各インデックスごとにその時点での身長の最大値を求める
-- 右畳み込みを使っているのがポイント
-- Lが昇順なので、時間とともに左にある値が消えていく状態なのもポイント。
-- scanr1 max [3,2,1]
-- [3,2,1]
-- NOTE: 検索時にO(1)で取得できるようにVector化している
suffMax :: [Int] -> V.Vector Int
suffMax hs = V.scanr1 max $ V.fromList hs

-- | tに最も近いlの値のあるlsのindexを求める
lowerBound :: V.Vector Int -> Int -> Int -> Int
lowerBound xs n target = go 0 n
  where
    go lo hi
      | lo >= hi = lo
      | xs V.! mid > target = go lo mid
      | otherwise = go (mid + 1) hi
      where
        mid = (lo + hi) `div` 2

solve :: Int -> [[Int]] -> [Int] -> [Int]
solve n hls ts = map (sMax V.!) is
  where
    [hs, ls] = transpose hls
    sMax = suffMax hs
    lsv = V.fromList ls
    is = map (lowerBound lsv n) ts -- 各tの時の最も近いlの値のあるlsのindexを求める

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      n = readInt $ head ls :: Int
      hls = map (map readInt . BS.words) $ take n $ tail ls :: [[Int]]
      ts = map readInt . BS.words $ ls !! (n + 2)
   in BS.unlines $ map (BS.pack . show) $ solve n hls ts
