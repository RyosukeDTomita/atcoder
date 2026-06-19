{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Vector qualified as V
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- 関係の転置(逆引き)をVector.accumulateで散布(scatter)する版。
-- 「jを探しに行く(gather)」のではなく「iから該当jへ配る(scatter)」。
-- reverseで昇順に戻し、先頭に人数を付ける
solve :: Int -> [[Int]] -> [[Int]]
solve n kas =
  [ length bs : bs
  | bs <- map reverse (V.toList res)
  ]
  where
    sent = map (drop 1) kas -- 個数はいらないので捨てる
    -- 辺(送信者i -> 受信者x)を (受信者index, 送信者i) のペアに反転
    pairs =
      V.fromList
        [ (x - 1, i) -- 受信者xは0-indexedで添字に、送信者iは値
        | (i, dests) <- zip [1 ..] sent,
          x <- dests
        ]
    -- 受信者をキーに送信者を散布。flip(:)で前置されるのでiの降順で溜まる
    -- ghci> V.accumulate (flip (:)) (V.replicate 3 []) $ V.fromList [(0,1), (2,2), (0, 3)]
    -- [[3,1],[],[2]]
    res = V.accumulate (flip (:)) (V.replicate n []) pairs

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      !n = read $ head ls :: Int
      !kas = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map (unwords . map show) $ solve n kas
