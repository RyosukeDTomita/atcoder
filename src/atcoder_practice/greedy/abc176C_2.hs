-- https://atcoder.jp/contests/abc176/tasks/abc176_c
-- 265 ms -> 473 msと遅くはなるが別解
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
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

-- scanl1 max asでその時点での最大値はもとめられる
-- あとは必要な踏み台のサイズをもとめるためにその時点での最大値とAの差をもとめる
solve :: [Int] -> Int
solve as = sum (scanl1 max as) - sum as

-- solve as = sum $ scanl1 (\a1 a2 -> max 0 (max a1 a2 - a2)) as -- これだと現在の最大値が次のstepに伝搬できないのでだめ。mapAccumL版を参照。

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"
