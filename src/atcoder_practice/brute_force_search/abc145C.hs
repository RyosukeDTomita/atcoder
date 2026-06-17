-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (permutations)
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

solve :: Int -> [[Int]] -> Double
solve n xys = sum (map pathLen paths) / fromIntegral nFact
  where
    paths = permutations xys
    nFact = product [1 .. n] -- 順列の総数 n!
    -- 経路の総距離: 隣接する点のペアをzipWithで取り出して合計
    -- ghci> paths = [[0,0],[1,0],[0,1]]
    -- ghci> zipWith (++) paths $ tail paths
    -- [[0,0,1,0],[1,0,0,1]]
    pathLen :: [[Int]] -> Double
    pathLen path = sum $ zipWith distance path $ tail path
    -- 2点間の距離を求める
    distance :: [Int] -> [Int] -> Double
    distance [ix, iy] [jx, jy] = sqrt $ fromIntegral $ (ix - jx) ^ 2 + (iy - jy) ^ 2

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      xys = map (map read . words) $ drop 1 ls :: [[Int]]
   in show (solve n xys) ++ "\n"
