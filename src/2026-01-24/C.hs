-- TLEした
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Vector.Unboxed qualified as VU
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
nCr n r = product [n - r + 1 .. n] `div` product [1 .. r]

-- 利害関係のない3人組を返す
threeReviewers :: Int -> [[Int]] -> VU.Vector Int
threeReviewers n abss =
  let reviewersMap = VU.replicate n 0 -- 1次元配列のindex番号+1の研究員の関係者の数
   in go reviewersMap abss
  where
    go reviewersMap [] = reviewersMap
    go reviewersMap ([a, b] : rest) =
      let reviewersMap' =
            reviewersMap
              VU.// [ (a - 1, reviewersMap VU.! (a - 1) + 1),
                      (b - 1, reviewersMap VU.! (b - 1) + 1)
                    ]
       in go
            reviewersMap'
            rest

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
