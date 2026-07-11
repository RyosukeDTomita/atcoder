{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
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

-- c: ボールの色
-- s: 大きさ
solve :: Int -> [[Int]] -> [Int]
solve m csList = reverse $ go [] $ assocs arr
  where
    arr = accumArray (flip (:)) [] (1, m) $ concatMap (\[c, s] -> [(c, s)]) csList -- Data.Arrayが全色埋めてくれている。
    go :: [Int] -> [(Int, [Int])] -> [Int]
    go result [] = result
    go result ((_, []) : rest) = go ((-1) : result) rest
    go result ((_, sList) : rest) = go (maximum sList : result) rest

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      csList = map (map read . words) $ drop 1 ls :: [[Int]]
   in unwords (map show (solve m csList)) ++ "\n"
