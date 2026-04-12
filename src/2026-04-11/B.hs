{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (mapAccumL)
import Data.Maybe (catMaybes)
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

solve :: Int -> Int -> [Int] -> [[Int]]
solve t x as = catMaybes . snd $ mapAccumL go 0 $ zip [0 .. t] as
  where
    go :: Int -> (Int, Int) -> (Int, Maybe [Int])
    go prevA (i, a) = if (abs (prevA - a) >= x) || (i == 0) then (a, Just [i, a]) else (prevA, Nothing)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        ![t, x] = map read . words $ head ls :: [Int]
        as = map read . words $ ls !! 1 :: [Int]
     in unlines . map (unwords . map show) $ solve t x as
