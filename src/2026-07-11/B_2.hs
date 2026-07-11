-- AC優先でData.Map前提で書いた再帰でACを通したが、foldl'のほうが美しいので書き直した。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
import Debug.Trace (traceShowId)
import Data.List (foldl')

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
solve m csList = reverse $ foldl' go [] $ assocs arr
  where
    arr = accumArray (flip (:)) [] (1, m) $ concatMap (\[c, s] -> [(c, s)]) csList -- Data.Arrayが全色埋めてくれている。
    go :: [Int] -> (Int, [Int]) -> [Int]
    go acc (_, [])　= (- 1) : acc
    go acc (_, sList) = maximum sList : acc

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      csList = map (map read . words) $ drop 1 ls :: [[Int]]
   in unwords (map show (solve m csList)) ++ "\n"
