-- https://atcoder.jp/contests/joi2022yo2/tasks/joi2022_yo2_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (mapAccumL)
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
solve ss = filter (/= "") $ snd $ mapAccumL go [] ss
  where
    go :: [String] -> String -> ([String], String)
    go acc s
      | s == "READ" = let (book : rest) = acc in (rest, book)
      | otherwise = (s : acc, "")

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- q = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ solve ss
