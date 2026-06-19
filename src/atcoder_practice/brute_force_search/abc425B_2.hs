-- https://atcoder.jp/contests/abc425/tasks/abc425_b
-- findを使うことでコード量めっちゃ減らせた
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (find, permutations)
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

-- (1..N)の全順列から、条件を満たすものを最初に1つ見つける。
-- 条件: 各iについて Ai == -1 または Pi == Ai。
solve :: Int -> [Int] -> [String]
solve n as = case find valid (permutations [1 .. n]) of
  Nothing -> ["No"]
  Just p -> ["Yes", unwords (map show p)]
  where
    valid :: [Int] -> Bool
    valid p =
      and
        [ a == -1 || p_i == a
        | (p_i, a) <- zip p as
        ] -- andで全部Trueの時だけTrueを返す

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = read (head ls) :: Int
        as = map read . words $ ls !! 1 :: [Int]
     in unlines (solve n as)
