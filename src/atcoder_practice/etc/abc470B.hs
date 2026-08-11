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

import Data.List (foldl', maximumBy)
import Data.Map.Strict qualified as Map
import Data.Maybe (fromJust)
import Data.Ord (comparing)
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}

debug :: Bool
debug = True

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

solve :: Int -> [Int] -> Int
solve n cs = n - fromJust (Map.lookup maxColor freq)
  where
    freq = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty cs
    maxColor = fst $ maximumBy (comparing snd) $ Map.toList freq

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        !cs = map read . words $ ls !! 1 :: [Int]
     in show (solve n cs) ++ "\n"
