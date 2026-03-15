{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Map.Strict qualified as Map
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

-- l <= s[j] - s[i] <= rを満たす(i,j)の組を求めるため、変形すると
-- s[i] + l >= s[j], s[j] <= s[i] + rを解く。
solve :: Int -> Int -> Int -> BS.ByteString -> Int
solve n l r s =
  Map.foldl' (\acc v -> acc + countPairs v) 0 (createCharMap s)
  where
    countPairs v =
      let k = VU.length v
       in sum
            [ upperBound v ((v VU.! i) + r) (i + 1) k
                - lowerBound v ((v VU.! i) + l) (i + 1) k
              | i <- [0 .. k - 2]
            ]

-- 二分探索を使い、s[i] + l >= s[j]を満たす最小のjを探す。
lowerBound :: VU.Vector Int -> Int -> Int -> Int -> Int
lowerBound v val lo hi
  | lo >= hi = lo
  | v VU.! mid >= val = lowerBound v val lo mid
  | otherwise = lowerBound v val (mid + 1) hi
  where
    mid = (lo + hi) `div` 2

-- 二分探索を使い、s[j] >= s[i] + rを満たす最小のjを求める
upperBound :: VU.Vector Int -> Int -> Int -> Int -> Int
upperBound v val lo hi
  | lo >= hi = lo
  | v VU.! mid > val = upperBound v val lo mid
  | otherwise = upperBound v val (mid + 1) hi
  where
    mid = (lo + hi) `div` 2

-- 同じ文字に対する出現インデックスのマップを作る
createCharMap :: BS.ByteString -> Map.Map Char (VU.Vector Int)
createCharMap bs =
  Map.map VU.fromList $
    foldr
      (\(i, c) m -> Map.insertWith (++) c [i] m)
      Map.empty
      (zip [0 ..] (BS.unpack bs))

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, l, r] = map readInt . BS.words $ head ls :: [Int]
        s = ls !! 1
     in (BS.pack . show) (solve n l r s) <> BS.pack "\n"
