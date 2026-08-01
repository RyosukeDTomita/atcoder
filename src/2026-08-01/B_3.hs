-- https://atcoder.jp/contests/abc469/submissions/78005737　を参考に実装
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

-- sの先頭と末尾に'x'を足せば右端と左端を特別扱いしなくて良くなる
-- zipWith3でxxxを見つける形にすれば更に分岐が減る
solve :: String -> Int
solve s = (length . filter id) $ zipWith3 (\a b c -> (a, b, c) == ('x', 'x', 'x')) s' (tail s') $ tail (tail s')
  where
    s' = 'x' : s ++ "x"

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in show (solve s) ++ "\n"
