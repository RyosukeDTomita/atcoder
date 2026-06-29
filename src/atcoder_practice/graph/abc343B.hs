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

-- 各行 as について、値が1の列番号 j を昇順に集める
solve :: [Int] -> [Int]
solve as = [j | (j, a) <- zip [1 ..] as, a == 1]

main :: IO ()
main = interact $ \inputs ->
  let ass = map (map read . words) . drop 1 $ lines inputs :: [[Int]]
   in unlines . map (unwords . map show . solve) $ ass
