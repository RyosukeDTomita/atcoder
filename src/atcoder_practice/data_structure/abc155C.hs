-- https://atcoder.jp/contests/abc155/tasks/abc155_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl', maximumBy)
import Data.Map qualified as Map
import Data.Ord (comparing)
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

solve :: [String] -> [String]
solve ss = reverse $ foldl' (\acc (w, n) -> if n == mostFreqN then w : acc else acc) [] mList
  where
    m = foldl' (\acc s -> Map.insertWith (+) s 1 acc) Map.empty ss
    mList = Map.toList m
    mostFreqN = snd $ maximumBy (comparing snd) mList :: Int

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ solve ss
