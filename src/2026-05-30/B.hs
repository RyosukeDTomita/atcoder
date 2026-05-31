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

solve :: [[Int]] -> [String]
solve cs = map go cs
  where
    -- floatにするのがだるいので2乗のまま比較している。
    go :: [Int] -> String
    go [x1, y1, r1, x2, y2, r2] =
      let d2 = (x1 - x2) ^ 2 + (y1 - y2) ^ 2 -- 中心同士の距離の2乗
       in if (r1 - r2) ^ 2 <= d2 && d2 <= (r1 + r2) ^ 2 then "Yes" else "No" --

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      t = read $ head ls :: Int
      cs = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines $ solve cs
