{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Debug.Trace (traceShowId)
import Data.List (sortOn)
import Data.Ord (Down (..))


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

solve :: Int -> Int -> Int -> [[Int]] -> [[Int]]
solve h w n hws =
  let psSortedByH = zip [1..n] $ sortOn (Down . head) hws
      psSortedByW = zip [1..n] $ sortOn (Down . (!! 1)) hws

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w, n] = map readInt . BS.words $ head ls :: [Int]
      hws = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
   in BS.unlines . map (BS.unwords . map (BS.pack . show)) $ solve h w n hws