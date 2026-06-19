-- https://atcoder.jp/contests/abc425/tasks/abc425_b
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (permutations)
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

solve :: Int -> [Int] -> [String]
solve n as = case go possibleP of
  Nothing -> ["No"]
  Just p -> ["Yes", unwords . map show $ p]
  where
    possibleP = permutations [1 .. n]
    go :: [[Int]] -> Maybe [Int]
    go [] = Nothing
    go (p : restP)
      | check $ zip p as = Just p
      | otherwise = go restP
      where
        check :: [(Int, Int)] -> Bool
        check [] = True
        check ((pi, ai) : rest)
          | ai == -1 = check rest
          | pi == ai = check rest
          | otherwise = False

main :: IO ()
main =
  interact $ \inputs ->
    let !ls = lines inputs
        !n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in unlines $ solve n as
