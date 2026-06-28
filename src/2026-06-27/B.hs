{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (transpose)
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
solve css = (trimColumns . trimRows) css
  where
    -- 上下の全白行を削除
    trimRows :: [String] -> [String]
    trimRows xss = (deleteBelow . deleteAbove) xss
    -- 転置して左右の全白列を上下の全白行として削除し, 戻す
    trimColumns :: [String] -> [String]
    trimColumns xss = (transpose . trimRows . transpose) xss
    deleteAbove :: [String] -> [String]
    deleteAbove xss@(xs : rest)
      | all (== '.') xs = deleteAbove rest
      | otherwise = xss
    deleteAbove [] = []
    deleteBelow :: [String] -> [String]
    deleteBelow xss
      | all (== '.') xs = deleteBelow $ init xss
      | otherwise = xss
      where
        xs = last xss

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      -- [h, w] = map read . words $ head ls :: [Int]
      css = drop 1 ls
   in unlines $ solve css
