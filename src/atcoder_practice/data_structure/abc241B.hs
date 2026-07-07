-- https://atcoder.jp/contests/abc241/tasks/abc241_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
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

solve :: [Int] -> [Int] -> String
solve as bs = if fst result then "Yes" else "No"
  where
    stock = foldl' (\acc a -> Map.insertWith (+) a 1 acc) Map.empty as
    result =
      foldr
        ( \b (ok, acc) -> case Map.lookup b acc of
            Just c -> if c > 0 then (ok, Map.insert b (c - 1) acc) else (False, acc)
            Nothing -> (False, acc)
        )
        (True, stock)
        bs

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      as = map read . words $ ls !! 1 :: [Int]
      bs = map read . words $ ls !! 2 :: [Int]
   in solve as bs ++ "\n"
