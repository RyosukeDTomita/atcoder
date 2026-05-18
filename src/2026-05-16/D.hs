-- TLEした。
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IM
import Data.List (foldl', mapAccumL)
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

frequency :: IM.IntMap Int -> [Int] -> IM.IntMap Int
frequency intMap ab = foldl' (\m x -> IM.insertWith (+) x 1 m) intMap ab

-- IntMap (値 -> 出現回数) から k 番目(1-indexed)に小さい値を返す
kthSmallest :: Int -> IM.IntMap Int -> Int
kthSmallest k im = go k (IM.toAscList im)
  where
    go _ [] = error "k out of range"
    go k' ((v, c) : rest)
      | k' <= c = v
      | otherwise = go (k' - c) rest

solve :: Int -> [[Int]] -> [Int]
solve x abList = snd $ mapAccumL go initialMap (zip [1 ..] abList)
  where
    initialMap = IM.singleton x 1
    go :: IM.IntMap Int -> (Int, [Int]) -> (IM.IntMap Int, Int)
    go intMap (i, ab) =
      let intMap' = frequency intMap ab
          median = kthSmallest (i + 1) intMap'
       in (intMap', median)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      x = readInt $ head ls :: Int
      abList = map (map readInt . BS.words) $ drop 2 ls :: [[Int]]
   in BS.unlines . map (BS.pack . show) $ solve x abList
