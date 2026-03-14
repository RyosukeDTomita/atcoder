-- TLE
-- sumの計算を等比数列の公式を使って高速化
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- 10^jを計算する
calJ :: Int -> Integer
calJ j = 10 ^ j

-- メモ化された10^jの結果
jVec :: V.Vector Integer
jVec = V.generate 200001 calJ

-- 等比級数の公式を使用
calB :: Int -> Integer
calB 0 = 0 -- 初期値
calB a = (jVec V.! a - 1) `div` 9

-- メモ化されたB_iの計算結果のVector
bVec :: V.Vector Integer
bVec = V.generate 200001 calB

solve :: [Int] -> Integer
solve as = sum $ map (bVec V.!) as

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"
