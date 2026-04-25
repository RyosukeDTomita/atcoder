{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (group, sort)
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

-- NOTE: groupは連続する同じ数をまとめる関数
-- ghci> group [1,1,2,3,3]
-- [[1,1],[2],[3,3]]
solve :: Int -> Int -> [Int] -> Int
solve n k aList =
  let contribs =
        sort
          [ head g * length g -- groupで集めた同じ数の合計を求める。
            | g <- group (sort aList)
          ]
   in sum $ take (length contribs - k) contribs -- k回実行するのはでかいやつから消すと最小値が求められる。

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, k] = map readInt . BS.words $ head ls :: [Int]
        aList = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve n k aList) <> BS.pack "\n"
