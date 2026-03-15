{-# LANGUAGE CPP #-}

import Control.Monad.Trans.Accum (mapAccum)
import Data.List (mapAccumL)
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

solve :: Int -> Int -> [[Int]] -> [Int]
solve h w qs = snd $ mapAccumL go (h, w) qs
  where
    go :: (Int, Int) -> [Int] -> ((Int, Int), Int)
    go (h, w) [t, i]
      | t == 1 = ((h - i, w), w * i)
      | t == 2 = ((h, w - i), h * i)
      | otherwise = error "invalid inputs"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [h, w, q] = map read . words $ head ls :: [Int]
      qs = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines $ map show (solve h w qs)
