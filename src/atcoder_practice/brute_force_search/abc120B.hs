-- https://atcoder.jp/contests/abc120/tasks/abc120_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# LANGUAGE BangPatterns #-}
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

solve :: [Int] -> Int
solve [a, b, k] =
  let gcd' = gcd a b
      !commonDivisors = dbgId $ filter (\x -> gcd' `mod` x == 0) [1 .. gcd']
   in reverse commonDivisors !! (k - 1) -- K番目に大きい数なので逆順にしている。

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
