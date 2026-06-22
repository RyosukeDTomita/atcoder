-- https://atcoder.jp/contests/abc292/tasks/abc292_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (mapAccumL)
import Data.Vector.Unboxed qualified as VU
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

solve :: Int -> [[Int]] -> [String]
solve n es = filter (/= "") $ snd $ mapAccumL go soccerPlayers es
  where
    soccerPlayers = VU.replicate n 2
    go :: VU.Vector Int -> [Int] -> (VU.Vector Int, String)
    go acc [c, x]
      | c == 1 = (acc VU.// [(x', (acc VU.! x') - 1)], "")
      | c == 2 = (acc VU.// [(x', (acc VU.! x') - 2)], "")
      | c == 3 = (acc, result)
      | otherwise = error "input is not valid"
      where
        x' = x - 1
        result = if acc VU.! x' <= 0 then "Yes" else "No"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, q] = map read . words $ head ls :: [Int]
      es = map (map read . words) $ tail ls :: [[Int]]
   in unlines $ solve n es
