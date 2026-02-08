-- メモ化ですべてを先に計算する不具合を修正
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Vector qualified as V
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

-- 10^jを計算する
calJ :: Int -> Integer
calJ j = 10 ^ j

solve :: [Int] -> Integer
solve as =
  let maxA = maximum as
      -- 必要な10^jだけを事前計算
      jVec = V.generate (maxA + 1) calJ
      -- 必要なB_iだけを事前計算
      calBMemo a = if a == 0 then 0 else (jVec V.! a - 1) `div` 9
      bVec = V.generate (maxA + 1) calBMemo
   in sum $ map (bVec V.!) as

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"