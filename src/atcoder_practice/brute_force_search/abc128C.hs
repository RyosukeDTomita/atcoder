-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Bits (shiftL, testBit)
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

-- ライトが点灯するかどうか
lit :: Int -> [Int] -> Int -> Bool
lit bit ks p =
  let switches = tail ks -- 先頭の接続数k_iを除いたスイッチ番号リスト
      onCount = length [s | s <- switches, testBit bit (s - 1)] -- testBitでそのスイッチが今回のbitパターンでオンかどうか判定する。NOTE: スイッチ番号を0スタートindexに直すため-1している
   in onCount `mod` 2 == p

-- スイッチの状態をbit全探索し、全電球が点灯するパターンを数える。
-- bit: on offのパターンを表す数値
solve :: Int -> [[Int]] -> [Int] -> Int
solve n ksList ps =
  length
    [ bit
      | bit <- [0 .. (1 `shiftL` n) - 1] :: [Int],
        and [lit bit ks p | (ks, p) <- zip ksList ps] -- 全部の電球が光るか。 NOTE: andはBoolのリストが全てTrueならTrueを返す
    ]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int]
        ksList = map (map read . words) $ (init . drop 1) ls :: [[Int]]
        ps = map read . words $ last ls :: [Int]
     in (show $ solve n ksList ps) ++ "\n"
