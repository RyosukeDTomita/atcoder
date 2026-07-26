-- さっと書いてみたがTLE
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (elemIndex, permutations, sort)
import Data.Maybe (fromJust)
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

solve :: Int -> [Int] -> [Int] -> Int
solve n ps qs = max 0 (qsN - psN - 1)
  where
    perm = sort $ permutations [1 .. n]
    psN = fromJust $ ps `elemIndex` perm
    qsN = fromJust $ qs `elemIndex` perm

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ps = map read . words $ ls !! 1 :: [Int]
        qs = map read . words $ ls !! 2 :: [Int]
     in show (solve n ps qs) ++ "\n"
