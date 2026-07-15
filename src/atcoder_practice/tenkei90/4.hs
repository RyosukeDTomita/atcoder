-- https://atcoder.jp/contests/typical90/tasks/typical90_d
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.List (transpose)
import Data.ByteString.Char8 qualified as BS

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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- 入力を全部1の3x3としてコメントを書いている
solve :: [[Int]] -> [[Int]]
solve bss = zipWith add rowSum bss --- zipWit add [3,3,3] [[1,1,1],[1,1,1],[1,1,1]]
  where
    rowSum = map sum bss
    colSum = map sum $ transpose bss
    add :: Int -> [Int] -> [Int]
    add r bs = zipWith (\c b -> r + c - b) colSum bs -- add 3 [1,1,1] = zipWith (\c b -> r + c - b) [3,3,3] [1]

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = lines inputs
      -- [h, w] = map read . words $ head ls :: [Int]
      bss = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
   in BS.unlines . map (BS.unwords . map (BS.pack . show)) $ solve bss
