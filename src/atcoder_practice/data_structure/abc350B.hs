-- https://atcoder.jp/contests/abc350/tasks/abc350_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Vector.Unboxed qualified as VU
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

solve :: Int -> [Int] -> Int
solve n ts = VU.length $ VU.filter id $ VU.foldl' go tooths $ VU.fromList ts
  where
    tooths = VU.replicate n True
    go :: VU.Vector Bool -> Int -> VU.Vector Bool
    go vs t = vs VU.// [(t - 1, not (vs VU.! (t - 1)))]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, _q] = map read . words $ head ls :: [Int]
        ts = map read . words $ ls !! 1 :: [Int]
     in show (solve n ts) ++ "\n"
