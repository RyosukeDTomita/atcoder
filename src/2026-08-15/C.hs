-- https://atcoder.jp/contests/abc471/tasks/abc471_c
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

import Data.Set qualified as Set
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}

debug :: Bool
debug = True

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

solve :: [Int] -> Int
solve as = go (0, 0, Set.fromList as)
  where
    -- \| 座標iから見てiより小さい座標のうち最大のもの or iよい大きい座標のうち最小のものを候補として取り出し、距離が近い方に移動する
    go :: (Int, Int, Set.Set Int) -> Int
    go (!result, i, aSet) -- iとaSetはパターンマッチで使われるのでここで正確評価にしても意味がない
    -- Set.emptyはパターンマッチで使えない。
      | Set.null aSet = result
      | otherwise = case (Set.lookupLT i aSet, Set.lookupGT i aSet) of
          (Just l, Nothing) -> go (result + abs (i - l), l, Set.delete l aSet)
          (Nothing, Just r) -> go (result + abs (i - r), r, Set.delete r aSet)
          (Just l, Just r) ->
            let dl = abs (i - l)
                dr = abs (i - r)
             in if dl <= dr then go (result + dl, l, Set.delete l aSet) else go (result + dr, r, Set.delete r aSet)
          (Nothing, Nothing) -> error "unreachable"

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
