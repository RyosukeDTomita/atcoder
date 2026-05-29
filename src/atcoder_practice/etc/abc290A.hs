-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

solve :: [Int] -> [Int] -> Int
solve as bs = sum $ map (\b -> as !! (b - 1)) bs

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, _m] = map read . words $ head ls :: [Int]
      as = (map read . words) $ ls !! 1 :: [Int]
      bs = (map read . words) $ ls !! 2 :: [Int]
   in show (solve as bs) ++ "\n"
