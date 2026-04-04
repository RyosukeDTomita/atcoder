{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.Set qualified as Set
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

-- 単語sを使い、条件を満たすオブジェが作れるか調べる
isExist :: Int -> BS.ByteString -> [Set.Set Char] -> BS.ByteString
isExist n s ribSets
  | BS.length s /= n = "No" -- 肋骨とsの長さは等しくなければならない。
  | all (\(i, cs) -> BS.index s i `Set.member` cs) (zip [0 ..] ribSets) = "Yes"
  | otherwise = "No"

-- 各A Bに対して条件を満たす文字のSetを前計算
ribCharSets :: [BS.ByteString] -> [[Int]] -> [Set.Set Char]
ribCharSets ss abList =
  [ Set.fromList [BS.index w (b - 1) | w <- ss, BS.length w == a]
    | [a, b] <- abList
  ]

-- sは短いのでわざわざVectorにしなくて良さそう
solve :: Int -> [[Int]] -> [BS.ByteString] -> [BS.ByteString]
solve n abList ss =
  let !ribSets = dbgId $ ribCharSets ss abList
   in map (\s -> isExist n s ribSets) ss

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
