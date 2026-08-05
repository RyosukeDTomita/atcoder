-- https://atcoder.jp/contests/abc397/tasks/abc397_c
-- TLEした
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.Set qualified as Set

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
solve as = go (0, Set.empty) as
  where
    go :: (Int, Set.Set Int) -> [Int] -> Int
    go (score, _) [] = score
    go (!score, !acc) (a: rest) = go (max score score', acc') rest
      where
        acc' = Set.insert a acc
        score' = Set.size acc' + Set.size (Set.fromList rest) -- Setの構築にO(n log n)なので全部でO(n^2 log n)


main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
