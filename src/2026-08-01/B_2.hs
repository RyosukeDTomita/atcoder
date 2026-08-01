{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (group)
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
solve :: String -> Int
solve s
  | length rls == 1 = if head s == 'x' then length s else 0
  | otherwise = sum (map (\x -> if head x == 'x' && length x >= 3 then (length x) - 2 else 0) rls) -- oの結果を弾くためにheadでチェックしている。ちなみに、length2回書いている分は2回評価されているのでもったいない感はある。
  where
    s' = 'x' : s ++ "x"
    !rls = dbgId $ group s'

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in show (solve s) ++ "\n"
