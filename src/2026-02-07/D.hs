-- TLE
-- B_iを求めるメモ化してキャッシュした。
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
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

calB :: Int -> Int
calB a =
  sum
    [ 10 ^ j
    | j <- [0 .. a - 1]
    ]

-- メモ化された計算結果のリスト
bList :: [Int]
bList = map calB [0 ..]

solve :: [Int] -> Int
solve as = sum $ map (bList !!) as

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"
