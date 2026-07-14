-- https://atcoder.jp/contests/typical90/submissions/me
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Set qualified as Set
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

solve :: Int -> String -> Int
solve n s = go (0, 1, 0)
  where
    n' = n - 1
    go :: (Int, Int, Int) -> Int
    go (!l, !r, !result)
      | l == n' = result
      | r > n' = go (l + 1, l + 2, result)
      | otherwise = if Set.size sSet' == 2 then go (l + 1, l + 2, cnt + result) else go (l, r + 1, result)
      where
        !s' = dbgId $ take (r - l + 1) $ drop l $ dbgId s -- このへんでうまいこと改行を消しているので入力に含まれる改行は気にしなくて良い。
        !sSet' = dbgId $ Set.fromList s'
        cnt = (n' - r + 1)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1 -- initで改行を消す
     in show (solve n s) ++ "\n"
