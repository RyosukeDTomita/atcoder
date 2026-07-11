-- https://atcoder.jp/contests/abc416/tasks/abc416_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad (replicateM)
import Data.Array
import Data.List (sort)
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

solve :: Int -> Int -> Int -> [String] -> String
solve n k x ss = (sort (map (f "") asList)) !! (x - 1)
  where
    asList = replicateM k [1 .. n] -- 直積
    sArr = listArray (1, length asList) ss -- i番目にO(1)でアクセスするため
    f :: String -> [Int] -> String
    f result [] = result
    f result (a : rest) = f (result ++ sArr ! a) rest

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, k, x] = map read . words $ head ls :: [Int]
        ss = tail ls
     in (solve n k x ss) ++ "\n"
