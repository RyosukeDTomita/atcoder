{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
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

-- どんな操作をするか?: a,b,cの辺のどれかの辺を選び2つに分割する
-- 操作をすると何が起きるか?: 1回切ると、a,b,cのどれか1つだけを分割した物体ができる
-- 最終的に満たすべき条件は?: すべての分割した物体の3辺が等しい。つまり、a,b,cの最大公約数を見つけてそれを達成するのに何手かかるか調べる。 -> 割り算で求められる
solve :: [Int] -> Int
solve [a, b, c] = a `div` gcdABC + b `div` gcdABC + c `div` gcdABC - 3
  where
    gcdABC = gcd (gcd a b) (gcd b c)

-- よく考えたら再帰せずに割り算でいい
-- go :: Int -> Int -> Int
-- go i x
--   | gcdABC == x = i
--   | otherwise = go (i + 1) (x - gcdABC)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
