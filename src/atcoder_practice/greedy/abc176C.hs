-- https://atcoder.jp/contests/abc176/tasks/abc176_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.List (mapAccumL)

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

solve :: [Int] -> Int
solve as = sum $ snd $ mapAccumL go 0 as
  where
    -- acc: 現時点での最大の身長
    -- outputとしてaccとの差分=必要な台のサイズを返す。
    go :: Int -> Int -> (Int, Int)
    go acc a
      | acc > a = (acc, acc - a)
      | acc <= a = (a, 0) -- acc == aのときはaccを更新する必要はないが、パターンマッチを減らすことを優先

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
