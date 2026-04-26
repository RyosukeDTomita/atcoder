-- https://atcoder.jp/contests/abc452/submissions/74664075 を参考に抽象化してみた。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.Map.Strict qualified as M
import Data.Set qualified as Set
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

-- 各肋骨の条件を満たす文字のSetをリスト化
-- M.findWithDefaultで長さaの単語が存在しない場合は空リストを返す
ribCharSets :: [BS.ByteString] -> [[Int]] -> [Set.Set Char]
ribCharSets ss abList =
  let wordsByLen = M.fromListWith (++) [(BS.length s, [s]) | s <- ss]
   in [ Set.fromList $
          map (\w -> BS.index w (b - 1)) $
            M.findWithDefault [] a wordsByLen
        | [a, b] <- abList
      ]

-- 単語Sでオブジェを作れるかチェックしている
isExist :: Int -> BS.ByteString -> [Set.Set Char] -> BS.ByteString
isExist n s possibleChars
  | BS.length s /= n = "No" -- 脊椎の長さはNでなければならない
  | all (\(c, cs) -> Set.member c cs) (zip (BS.unpack s) possibleChars) = "Yes"
  | otherwise = "No"

solve :: Int -> [[Int]] -> [BS.ByteString] -> [BS.ByteString]
solve n abList ss =
  let !possibleChars = dbgId $ ribCharSets ss abList
   in map (\s -> isExist n s possibleChars) ss

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      !n = readInt $ head ls :: Int -- 肋骨の数および、脊髄に書く文字列の長さ
      !abList = map (map readInt . BS.words) $ take n $ drop 1 ls :: [[Int]] -- A: 肋骨iに書く文字列の長さ B: 脊椎に各文字列のB文字目と一致させる制約がある
      m = readInt $ ls !! (n + 1) :: Int
      !ss = drop (n + 2) ls -- 脊椎に各文字列と使用できる言葉
   in BS.unlines $ solve n abList ss
