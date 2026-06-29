-- https://atcoder.jp/contests/abc343/tasks/abc343_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
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

solve :: [Int] -> [Int]
solve as = [j | (j, a) <- zip [1 ..] as, a == 1] -- zipで頂点の番号を降る

main :: IO ()
main = interact $ \inputs ->
  let ass = map (map read . words) . drop 1 $ lines inputs :: [[Int]]
   in unlines . map (unwords . map show . solve) $ ass -- assを受け取って二次元リストをこねくり回すよりも呼び出し元でmapしたほうがきれいにかけそう
