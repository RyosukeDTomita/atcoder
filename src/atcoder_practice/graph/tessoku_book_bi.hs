-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_bi
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Data.List (intercalate, sort)
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
solve n abList = map addHeader abj
  where
    abj = assocs $ accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList
    addHeader :: (Int, [Int]) -> String
    addHeader ass = show (fst ass) ++ ": " ++ "{" ++ intercalate ", " (map show ((sort . snd) ass)) ++ "}"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines $ solve n abList
