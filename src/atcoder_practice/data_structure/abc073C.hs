{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
import Data.Set qualified as Set
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

solve :: [Int] -> Int
solve as = Set.size $ foldl' go Set.empty as
  where
    go :: Set.Set Int -> Int -> Set.Set Int
    go s a
      | a `Set.member` s = Set.delete a s
      | otherwise = Set.insert a s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read $ tail ls :: [Int]
     in show (solve as) ++ "\n"
