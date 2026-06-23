-- https://atcoder.jp/contests/abc308/tasks/abc308_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
import Data.Map qualified as Map
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

-- Map.findWithDefaultを使った方が楽かも
solve :: [String] -> [String] -> [Int] -> Int
solve cs ds (p0 : ps) = foldl' (\acc c -> acc + Map.findWithDefault p0 c menu) 0 cs
  where
    menu = Map.fromList $ zip ds ps

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        cs = words $ ls !! 1
        ds = words $ ls !! 2
        ps = map read . words $ ls !! 3 :: [Int]
     in show (solve cs ds ps) ++ "\n"
