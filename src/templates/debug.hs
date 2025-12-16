{-# LANGUAGE CPP #-}

import Control.Arrow ((>>>))
import Data.List (mapAccumL)
import Data.Set qualified as S
import Debug.Trace

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

-- 値を表示したいが、その値を使わない場合
dbg :: (Show a) => a -> ()
dbg x
  | debug = let !_ = traceShow x () in ()
  | otherwise = ()

-- 値を表示しつつ、その値を使う場合
dbgId :: (Show a) => a -> a
dbgId x
  | debug = let !_ = traceShow x () in x
  | otherwise = x

dbgId' :: (Show a) => a -> a
dbgId' x
  | debug = traceShowId x
  | otherwise = x

-- リストから偶数だけを取り出して冒頭nの合計を出す。
solve :: [Int] -> Int -> Int
solve xs n =
  -- let evenXs = filter (even) xs
  --     takeXs = traceShow evenXs take n evenXs -- traceShowだと評価される場所にしかかけない
  -- let evenXs = dbgId (filter even xs)
  --     takeXs = take n evenXs
  -- let evenXs = traceShowId (filter even xs)
  --     takeXs = take n evenXs
  let evenXs = dbgId' (filter even xs)
      takeXs = take n evenXs
   in sum takeXs

main :: IO ()
main = do
  let result = solve [1, 2, 3, 4, 5] 3
  print result
