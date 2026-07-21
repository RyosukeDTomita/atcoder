-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_bc
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.Set qualified as Set
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

solve :: [[Int]] -> [Int]
solve qs = reverse $ snd $ foldl' go (Set.empty, []) qs
  where
    go :: (Set.Set Int, [Int]) -> [Int] -> (Set.Set Int, [Int])
    go (acc, output) [i, x]
      | i == 1 = (Set.insert x acc, output)
      | i == 2 = (Set.delete x acc, output)
      | i == 3 =  case Set.lookupGE x acc of
        Just gtX -> (acc, gtX : output)
        Nothing -> (acc, (-1) : output)
      | otherwise = error "input is not valid"

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        qs = map (map read . words) $ tail ls :: [[Int]]
     in unlines $ map show $ solve qs
