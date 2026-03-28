{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (transpose)
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

frequency :: [Int] -> Int -> VU.Vector Int
-- NOTE: accumulateは第2引数に初期ベクタ、第3引数の(index番号, value)をとり、f valueを初期ベクタのn番目に適用する関数である。
frequency xs maxX = VU.accumulate (+) (VU.replicate (maxX + 1) 0) (VU.fromList [(x, 1) | x <- xs])

solve :: [Int] -> [Int] -> Int -> [Int]
solve as bs m =
  let !curDepNum = dbgId $ frequency as m
      !updatedDepNum = dbgId $ frequency bs m
   in tail $ VU.toList $ VU.zipWith (-) updatedDepNum curDepNum

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [_, m] = map read . words $ head ls :: [Int]
      [!as, !bs] = transpose $ map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map show $ solve as bs m
