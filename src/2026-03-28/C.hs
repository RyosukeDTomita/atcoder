{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (mapAccumL)
import Data.Map.Strict qualified as Map
import Data.Maybe (fromMaybe)
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

solve :: [[Int]] -> [Int]
solve qs = snd $ mapAccumL step (Map.empty, 0) qs
  where
    -- (m, cnt): 木の高さ, 木の本数のmap
    -- query
    -- 戻り値: ((m, cnt), 現在のquery適用後の木の本数)
    -- NOTE: いろいろBang Patternを使って変数を正格評価にしてみたがむしろ遅くなった。
    step :: (Map.Map Int Int, Int) -> [Int] -> ((Map.Map Int Int, Int), Int)
    step (m, cnt) [1, h] =
      let m' = Map.insertWith (+) h 1 m
          cnt' = cnt + 1
       in ((m', cnt'), cnt')
    step (m, cnt) [2, h] =
      let (lo, atH, hi) = Map.splitLookup h m -- hより小さい、hと等しい、hより大きいの3つに分割する。atHがMaybe Intなのに注意
          removed = Map.foldl' (+) 0 lo + fromMaybe 0 atH -- 何本消えたかカウント
          cnt' = cnt - removed
       in ((hi, cnt'), cnt')
    step acc _ = (acc, 0)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      _ = readInt $ head ls :: Int
      qs = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
   in BS.unlines $ map (BS.pack . show) $ solve qs
