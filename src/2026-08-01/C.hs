-- 愚直にやるとTLEする
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (mapAccumL)
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: Int -> BS.ByteString -> [Int]
solve n s = snd $ mapAccumL go 0 [1 .. n]
  where
    go :: Int -> Int -> (Int, Int)
    go acc k
      | n == acc = (n, n)
      | otherwise = (result, result)
      where
        result = k + step initialAtari rs
        (ls, rs) = BS.splitAt k s
        initialAtari = (BS.length . BS.filter (== 'o')) ls
        step :: Int -> BS.ByteString -> Int
        step 0 _ = 0
        step !stock !t = case BS.uncons t of
          Nothing -> 0
          Just (c, rest) -> if c == 'o' then 1 + step stock rest else 1 + step (stock - 1) rest

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        s = ls !! 1
     in BS.unlines $ map (BS.pack . show) (solve n s)
