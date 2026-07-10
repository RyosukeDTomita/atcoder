-- https://atcoder.jp/contests/abc416/tasks/abc416_c
-- fの内部処理を手再帰からfoldl'に変えた
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Control.Monad (replicateM)
import Data.List (sort, foldl')
import Data.Array

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

solve :: Int -> Int -> Int -> [String] -> String
solve n k x ss = (sort (map f asList)) !! (x - 1)
  where
    asList = replicateM k [1..n]
    sArr = listArray (1, length asList) ss
    f :: [Int] -> String
    f as = foldl' (\acc a -> acc ++ sArr ! a) "" as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, k, x] = map read . words $ head ls :: [Int]
        ss = tail ls
     in (solve n k x ss) ++ "\n"
