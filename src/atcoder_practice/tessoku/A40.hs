-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_an
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.Map qualified as Map
import Data.List (foldl')

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

nCr :: Int -> Int -> Int
nCr n r = product [n - r + 1 .. n] `div` product [1 .. r]

solve :: [Int] -> Int
solve as = foldl' (\acc (k, x) -> if x >= 3 then acc + (nCr x 3) else acc) 0 $ Map.toList freq
  where
    freq = foldl' (\acc i ->  Map.insertWith (+) i 1 acc) Map.empty as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
