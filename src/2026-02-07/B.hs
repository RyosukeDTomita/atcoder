{-# LANGUAGE CPP #-}

import Control.Arrow ((>>>))
import Data.Char (digitToInt, intToDigit)
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

sumDigitIsK :: Int -> Int -> Bool
sumDigitIsK k n =
  let sumDigit = sum $ map digitToInt $ show n
   in k == sumDigit

solve :: [Int] -> Int
solve [n, k] = length $ filter (sumDigitIsK k) [0 .. n]

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")