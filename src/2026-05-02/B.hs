{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (permutations)
import Debug.Trace (traceShowId)
import Text.Printf (printf)

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

-- サイコロは必ず3つなので4,5,6がどのダイスで出るかのパターンは6通り。
solve :: [[Int]] -> Double
solve ass =
  let patterns = permutations [4, 5, 6]
      sumCase = sum $ map count patterns
   in (fromIntegral sumCase :: Double) / (fromIntegral 216 :: Double)
  where
    -- 指定したパターン(e.g. [4,5,6])を満たすダイスのパターンをカウント
    count :: [Int] -> Int
    count p =
      let a1Result = length $ filter (== head p) (head ass)
          a2Result = length $ filter (== p !! 1) (ass !! 1)
          a3Result = length $ filter (== p !! 2) (ass !! 2)
       in a1Result * a2Result * a3Result

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      !ass = map (map read . words) ls :: [[Int]]
   in printf "%.10f\n" (solve ass)
