-- https://atcoder.jp/contests/abc367/tasks/abc367_c
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

-- 残りのR たちから作れる数列を「全パターンのリスト」として返す。
-- x を1から順に選ぶので、結果は辞書順に並ぶ。
go :: [Int] -> [[Int]]
go [] = [[]] -- 空列が1通り。[] にすると全部消えるので注意
go (r : rest) = [x : ys | x <- [1 .. r], ys <- go rest]

solve :: Int -> [Int] -> [[Int]]
solve k rs = filter (\xs -> sum xs `mod` k == 0) $ go rs

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, k] = map read . words $ head ls :: [Int]
        rs = map read . words $ ls !! 1 :: [Int]
     in unlines . map (unwords . map show) $ solve k rs
