{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
-- import qualified Data.ByteString.Char8 as BS -- AOJ
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

solve :: Int -> [Int] -> Int
solve k ws = binarySearch 0 (sum ws) ws k

-- lower
-- upper
-- ws
-- トラックの数
binarySearch :: Int -> Int -> [Int] -> Int -> Int
binarySearch lower upper ws k
  | lower < upper =
      let mid = (lower + upper) `div` 2
       in if canLoad mid ws k
            then
              binarySearch lower mid ws k
            else
              binarySearch (mid + 1) upper ws k
  | otherwise = lower

-- p: 最大積載量
-- ws
-- k: トラックの数
canLoad :: Int -> [Int] -> Int -> Bool
canLoad p ws k = go ws 1 0
  where
    -- ws
    -- trucks: 使用済みのトラックの数
    -- current: 現在のトラックに載っている重さ
    go [] trucks _ = trucks <= k -- すべてのwsを積んだときに必要な最小のトラックの数がk以下か
    go (w : ws) trucks current
      | w > p = False
      | current + w <= p = go ws trucks (current + w) -- 既存のトラックに載せる
      | otherwise = go ws (trucks + 1) w -- 新しいトラックに載せる

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, k] = map readInt . BS.words $ head ls :: [Int]
        ws = map readInt $ tail ls :: [Int]
     in (BS.pack . show) (solve k ws) <> BS.pack "\n"