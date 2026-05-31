{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (sort)
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

-- as シャリ
-- bs ネタ
solve :: [Int] -> [Int] -> Int
solve as bs = go 0 as' bs'
  where
    go :: Int -> [Int] -> [Int] -> Int
    go cnt _ [] = cnt
    go cnt [] _ = cnt
    go cnt (x : xRest) (y : yRest)
      | y <= 2 * x = go (cnt + 1) xRest yRest
      | otherwise = go cnt xRest (y : yRest)
    !as' = dbgId $ sort as
    !bs' = dbgId $ sort bs

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, m] = map readInt . BS.words $ head ls :: [Int]
        as = map readInt . BS.words $ ls !! 1 :: [Int]
        bs = map readInt . BS.words $ ls !! 2 :: [Int]
     in (BS.pack . show) (solve as bs) <> BS.pack "\n"
