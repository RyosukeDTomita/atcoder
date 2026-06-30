-- https://atcoder.jp/contests/typical90/tasks/typical90_bo
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.Char (digitToInt, intToDigit)
import Data.List (foldl', unfoldr)
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

-- | 10進法数値を9進法文字列にする
toNineDecimal :: Int -> String
toNineDecimal 0 = "0"
toNineDecimal n = reverse $ unfoldr go n
  where
    go :: Int -> Maybe (Char, Int)
    go 0 = Nothing
    go n =
      let (q, r) = n `divMod` 9
       in Just (intToDigit r, q)

-- | 8進法文字列を10進法数値にする
fromOctal :: String -> Int
fromOctal s = foldl' (\acc c -> acc * 8 + digitToInt c) 0 s

solve :: [String] -> String
solve [nStr, kStr] = iterate go nStr !! read kStr
  where
    -- \| 1回の操作: Nを9進法に直し、8を5に置き換える(結果は次の8進文字列)
    go :: String -> String
    go s = map (\c -> if c == '8' then '5' else c) $ (toNineDecimal . fromOctal) s

main :: IO ()
main =
  interact $
    words >>> solve >>> (++ "\n")
