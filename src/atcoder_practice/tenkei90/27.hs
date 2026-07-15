-- https://atcoder.jp/contests/typical90/tasks/typical90_aa
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

solve :: [String] -> [Int]
solve ss = reverse $ snd $ foldl' go (Set.empty, []) $ zip [1..] ss
  where
    go :: (Set.Set String, [Int]) -> (Int, String) -> (Set.Set String, [Int])
    go (set, output) (i, s)
      | s `Set.member` set  = (set, output)
      | otherwise = (Set.insert s set, i: output)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ map show $ solve ss
