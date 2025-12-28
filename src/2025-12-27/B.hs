{-# LANGUAGE CPP #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.Char (digitToInt)
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

solve :: String -> String -> Int
solve sString tString =
  -- [Int]にする
  let sIntList = map digitToInt sString
      tIntList = map digitToInt tString
   in go sIntList tIntList $ maxBound :: Int -- NOTE: 初期値は念の為、Intの最大値にした
  where
    -- sの(length t)桁にtを変化させるまでに何回操作が必要かを全パターンで求めて最小値を返す
    go sIntList tIntList result
      | length sIntList == length tIntList =
          let result' = count sIntList tIntList 0
           in min result result'
      | otherwise =
          let (s, sRest) = splitAt (length tIntList) sIntList
              -- result' = dbgId $ count s tIntList 0
              result' = count s tIntList 0
           in go (tail sIntList) tIntList (min result result')

-- s
-- t
-- n: 現在の試行回数を保存する
count :: [Int] -> [Int] -> Int -> Int
count [] [] n = n
count s@(s0 : sRest) t@(t0 : tRest) n
  | s == t = n
  | s0 == t0 = count sRest tRest n
  | otherwise = count s ((plusOne t0) : tRest) (n + 1)

-- ある桁に1増やす
plusOne :: Int -> Int
plusOne x
  | x <= 8 = x + 1
  | otherwise = 0 -- 9

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- [n, m] = map read . words $ head ls :: [Int]
        s = ls !! 1
        t = ls !! 2
     in show (solve s t) ++ "\n"