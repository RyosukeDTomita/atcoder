-- https://atcoder.jp/contests/abc456/submissions/75416780 を参考に実装
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad (guard)
import Data.List (sort)
import Debug.Trace (traceShowId)
import Text.Printf (printf)

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

solve :: [[Int]] -> Double
solve ass =
  let p :: Double =
        -- (fromIntegral . length)
        fromIntegral $
          length
            -- リストモナドで書いてみる。
            ( do
                a <- head ass
                b <- ass !! 1
                c <- ass !! 2
                guard $ sort [a, b, c] == [4, 5, 6]
                return () :: [()] -- 個数以外は別にいらないので最低限の()を返す。
            )
   in p / 216

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      !ass = map (map read . words) ls :: [[Int]]
   in printf "%.10f\n" (solve ass)
