-- https://atcoder.jp/contests/abc116/tasks/abc116_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Control.Arrow ((>>>))
import Debug.Trace (traceShowId)
import Data.List (inits)

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

-- 手再帰のgoを使わない版: inits xsが各要素より前のprefix(=goのprevs)を与える
-- zipWithの部分でやっていること
-- xs       =  8,   4,     2,       1,         4, ...
-- inits xs = [[], [8], [8,4], [8,4,2], [8,4,2,1], ...]
-- inits xsが[]スタートなので1つずれている。
-- elem 8  []           = False
-- elem 4  [8]          = False
-- elem 2  [8,4]        = False
-- elem 1  [8,4,2]      = False
-- elem 4  [8,4,2,1]    = True    -- 4は既出!ここがm=5(1-based)
--
-- takeWhile部分でやっていること
-- takeWhile notでTrueFalseを逆転しつつ、評価をしている(普通にbool渡すだけだとidがいる)
-- 止まった時点でのリストの長さ + 1が答えになる。(initsの最初の値が[]であり、現在のf xの値を含まないものでとまるため)。
solve :: Int -> Int
solve s = (1 +) . length . takeWhile not $ zipWith elem xs $ inits xs
  where
    xs :: [Int]
    xs = iterate f s
    f :: Int -> Int
    f n
      | even n = n `div` 2
      | otherwise = 3 * n + 1

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
