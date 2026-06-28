{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.Array (accumArray, (!))
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl', mapAccumL)
import Data.Map.Strict qualified as Map
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

-- その色の鳥の数のMap, 色の種類数
type Counts = (Map.Map Int Int, Int)

-- 色col を1つ減らし、0になったら種類数distinctを1減らす
dec :: Counts -> Int -> Counts
dec (mp, dist) col = case Map.lookup col mp of
  Just 1 -> (Map.delete col mp, dist - 1) -- その色が最後の1羽の場合種類数を増やす
  Just c -> (Map.insert col (c - 1) mp, dist)
  Nothing -> (mp, dist)

-- 色col を1つ増やし、0->1なら種類数distinctを1増やす
inc :: Counts -> Int -> Counts
inc (mp, dist) col = case Map.lookup col mp of
  Nothing -> (Map.insert col 1 mp, dist + 1) -- 現時点で存在しない色の場合種類数を増やす
  Just c -> (Map.insert col (c + 1) mp, dist)

-- 鳥1羽の変化を適用する
change :: Counts -> (Int, Int) -> Counts
change st (a, b) = inc (dec st a) b

solve :: Int -> [[Int]] -> [Int]
solve m adbs = snd $ mapAccumL go birds [1 .. m]
  where
    dbs :: [(Int, Int, Int)]
    dbs = [(a, d, b) | [a, d, b] <- adbs]
    -- 1日目の色だけ適応してからMap化
    initMap = Map.fromListWith (+) [(if d == 1 then b else a, 1) | (a, d, b) <- dbs]
    birds = (initMap, Map.size initMap)
    -- D>=2の鳥の変化を日付ごとにまとめる
    changesByDay = accumArray (flip (:)) [] (1, m) [(d, (a, b)) | (a, d, b) <- dbs, d >= 2]
    go :: Counts -> Int -> (Counts, Int)
    go st day = (st', sndSt)
      where
        st' = foldl' change st (changesByDay ! day)
        !sndSt = snd st' -- これで200ms速くなった

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [_, m] = map readInt . BS.words $ head ls :: [Int] -- n: 鳥の数、m: 観察日数
      adbs = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
   in BS.unlines $ map (BS.pack . show) $ solve m adbs
