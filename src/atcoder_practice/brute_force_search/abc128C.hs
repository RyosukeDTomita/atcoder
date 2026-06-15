{-# LANGUAGE BangPatterns #-}
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

solve :: [[Int]] -> [Int] -> Int
solve ksList ps =
  let !tmp = dbgId $ ksList
      !tmp2 = dbgId $ ps
   in 1

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int]
        ksList = map (map read . words) $ (init . drop 1) ls :: [[Int]]
        ps = map read . words $ last ls :: [Int]
     in (show $ solve ksList ps) ++ "\n"
