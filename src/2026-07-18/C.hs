{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.Array
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- m=2固定の場合
-- b_i == 0 -> a_i + a_(i+1) `mod` 2 == 0
-- b_i == 1 -> a_i + a_(i+1) `mod` 2 == 1
--
solve :: Int -> [Int] -> [Int] -> Int
solve n aList bList = fst $ foldl' go (0, aijArr) $ zip [1 ..] bList
  where
    -- !aijList = dbgId $ zipWith (+) aList $ tail aList
    aijList = zipWith (+) aList $ tail aList
    aijArr = listArray (1, n) aijList
    go :: (Int, Array Int Int) -> (Int, Int) -> (Int, Array Int Int)
    go (n, arr) (i, b)
      | (arr ! i) `mod` 2 == b = (n, arr)
      | otherwise = (n + 1, arr // [(i, (arr ! i) + 1), (i + 1, (arr ! (i + 1) + 1))])

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [n, _m] = map readInt . BS.words $ head ls :: [Int] -- m=2
      aList = map readInt . BS.words $ ls !! 1 :: [Int]
      bList = map readInt . BS.words $ ls !! 2 :: [Int]
   in ((BS.pack . show) (solve n aList bList)) <> BS.pack "\n"
