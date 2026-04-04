-- TLEになった
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
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

-- 文字列の長さごとに単語を分類する
classifySS :: Int -> [BS.ByteString] -> V.Vector [BS.ByteString]
-- NOTE: accumulateは第2引数に初期ベクタ、第3引数の(index番号, value)をとり、f valueを初期ベクタのn番目に適用する関数である。
classifySS maxLength ss =
  V.accumulate (flip (:)) (V.replicate (maxLength + 1) []) $
    -- maxLengthを超える単語はV.accumulateで範囲外アクセスになるためフィルタする
    V.fromList [(BS.length s, s) | s <- ss, BS.length s <= maxLength]

-- 単語sを使い、条件を満たすオブジェが作れるか調べる
isExist :: BS.ByteString -> [[Int]] -> V.Vector [BS.ByteString] -> BS.ByteString
isExist s abList wordMap
  -- 脊椎の長さはNでなければならない
  | BS.length s /= length abList = "No"
  | otherwise = go s abList
  where
    go :: BS.ByteString -> [[Int]] -> BS.ByteString
    go _ [] = "Yes"
    go sRest (ab : abRest) = case BS.uncons sRest of
      Nothing -> "Yes"
      Just (c, sRest') ->
        let a = head ab
            b = ab !! 1
            wordLengthA = wordMap V.! a
            result = any (\w -> BS.index w (b - 1) == c) wordLengthA -- これが重たい。
         in if not result then "No" else go sRest' abRest

-- sは短いのでわざわざVectorにしなくて良さそう
solve :: Int -> [[Int]] -> [BS.ByteString] -> [BS.ByteString]
solve n abList ss =
  -- nではなくaの最大値をmaxLengthにする。nより大きいaが存在するとwordMap V.! a が範囲外アクセスになるため
  let maxA = maximum $ map head abList
      !wordMap = dbgId $ classifySS maxA ss
   in map (\s -> isExist s abList wordMap) ss

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      !n = readInt $ head ls :: Int -- 肋骨の数および、脊髄に書く文字列の長さ
      -- !abList = dbgId $ map (map readInt . BS.words) $ take n $ drop 1 ls :: [[Int]]
      -- !m = dbgId $ readInt $ ls !! (n + 1) :: Int
      -- !ss = dbgId $ BS.unlines $ drop (n + 1) ls
      !abList = map (map readInt . BS.words) $ take n $ drop 1 ls :: [[Int]] -- A: 肋骨iに書く文字列の長さ B: 脊椎に各文字列のB文字目と一致させる制約がある
      m = readInt $ ls !! (n + 1) :: Int
      !ss = drop (n + 2) ls -- 脊椎に各文字列と使用できる言葉
   in BS.unlines $ solve n abList ss
