-- https://atcoder.jp/contests/abc293/tasks/abc293_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wmissing-local-signatures #-}
{-# OPTIONS_GHC -Wmissing-signatures #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wtype-defaults #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- TLE調査時に有効化する。MRが適用されて単相化された(=共有が効いている)束縛を報告する。
-- {-# OPTIONS_GHC -Wmonomorphism-restriction #-}

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

solve :: Int -> [Int] -> [Int]
solve n xs = Set.toList $ foldl' go set $ zip [1 ..] xs
  where
    set = Set.fromList [1 .. n]
    go :: Set.Set Int -> (Int, Int) -> Set.Set Int
    go acc (i, x)
      | Set.member i acc = Set.delete x acc
      | otherwise = acc

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        xs = map read . words $ ls !! 1 :: [Int]
        result = solve n xs
     in (show . length) result ++ "\n" ++ unwords (map show result) ++ "\n"
