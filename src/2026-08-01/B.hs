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

-- 先頭と末尾は別で考えるべき?
-- それ以外はxxxの中心をカウントすれば良さそう?
solve :: String -> Int
solve s
  | length rls == 1 = if head s == 'x' then length s else 0 -- groupが1種類の時
  | otherwise = (headResult + lastResult) + sum (map (\x -> if head x == 'x' && length x >= 3 then (length x) - 2 else 0) $ (drop 1 . take (length rls - 1)) rls) -- oの結果を弾くためにheadでチェックしている
  where
    !rls = dbgId $ group s
    headResult = case head rls of
      ('x' : 'x' : _) -> length (head rls) - 1
      _ -> 0
    lastResult = case last rls of
      ('x' : 'x' : _) -> length (last rls) - 1
      _ -> 0

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        s = ls !! 1
     in show (solve s) ++ "\n"
