{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
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

nCr :: Int -> Int -> Int
nCr n r
  | r > n || r < 0 = 0
  | r == 0 || r == n = 1
  | otherwise = product [n - r + 1 .. n] `div` product [1 .. r]

-- 利害関係のない3人組を返す
threeReviewers :: Int -> [[Int]] -> VU.Vector Int
threeReviewers n abss = runST $ do
  reviewersMap <- VUM.replicate n 0
  forM_ abss $ \[a, b] -> do
    VUM.modify reviewersMap (+ 1) (a - 1)
    VUM.modify reviewersMap (+ 1) (b - 1)
  VU.freeze reviewersMap

solve :: Int -> [[Int]] -> [Int]
solve n abss =
  let reviewersMap = threeReviewers n abss
   in VU.toList $ VU.map (\r -> (n - r - 1) `nCr` 3) reviewersMap -- 自分は査読者になれないので-1

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [n, _] = map readInt . BS.words $ head ls :: [Int] -- 研究者の数, 利害関係の個数
      abss = map (map readInt . BS.words) $ tail ls :: [[Int]]
   in (BS.unwords . map (BS.pack . show) $ solve n abss) <> BS.pack "\n"
