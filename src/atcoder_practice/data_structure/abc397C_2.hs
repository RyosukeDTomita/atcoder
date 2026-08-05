-- https://atcoder.jp/contests/abc397/tasks/abc397_c
-- WA
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

-- 都度Setを構築しなくていいようにrightを全体のSetからdeleteして作る --> 本来消しては行けないものも消してしまうのでWA
solve :: [Int] -> Int
solve as = go (0, Set.empty, Set.fromList as) as
  where
    go :: (Int, Set.Set Int, Set.Set Int) -> [Int] -> Int
    go (score, _, _) [] = score
    go (!score, !left, !right) (a: rest) = go (max score score', left', right') rest
      where
        left' = Set.insert a left
        right'= Set.delete a right
        score' = Set.size left' + Set.size right'


main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
