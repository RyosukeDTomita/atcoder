-- TLEした
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IM
import Data.IntSet qualified as IntSet
import Data.List (sort, sortOn)
import Data.Ord (Down (..))
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

-- |
-- "C V" の1行を(色, 価値)のタプルに変換する
readPair :: BS.ByteString -> (Int, Int)
readPair l =
  case map readInt (BS.words l) of
    [c, v] -> (c, v)
    _ -> error "expected two integers"

-- k: 選べる宝石の数
-- m: 必要な種類
-- cvs: (色, 価値)のリスト
solve :: Int -> Int -> [(Int, Int)] -> Int
-- solve k m cvs = baseSum - removeSum + addSum
solve k m cvs = if need == 0 then baseSum else baseSum - removeSum + addSum
  where
    sorted = sortOn (Down . snd) cvs -- 価値の降順
    (selected, rest) = splitAt k sorted -- 上位K個と残り
    selectedColors = IntSet.fromList (map fst selected) -- 選択内の色集合
    baseSum = sum (map snd selected) -- とりあえずの上位k個の価値の和
    need = m - IntSet.size selectedColors -- 追加で必要な色数(0以下ならスワップ不要)

    -- 捨てる
    grouped = IM.fromListWith (flip (++)) [(c, [v]) | (c, v) <- selected] -- 色ごとに価値リストにまとめる
    extras = sort $ concatMap (drop 1) $ IM.elems grouped -- 値だけ取り出して、先頭を捨ててそれ以外を結合してsortすることで色がダブったものを抽出する。
    removeSum = sum (take need extras) -- 捨てた宝石の価値の合計

    -- 入れる: 未選択色ごとの最大価値の石を追加
    candidates = IM.fromListWith max [(c, v) | (c, v) <- rest, c `IntSet.notMember` selectedColors]
    addSum = sum $ take need $ sortOn Down (IM.elems candidates) -- 追加する石の合計

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [_, k, m] = map readInt . BS.words $ head ls :: [Int]
      !cvs = map readPair $ drop 1 ls :: [(Int, Int)]
   in BS.pack (show (solve k m cvs)) <> "\n"
