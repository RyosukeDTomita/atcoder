{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Maybe (fromJust)
import Data.Vector qualified as V
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: [Int] -> BS.ByteString
solve as =
  let !maxA = maximum as

      -- Aが何回出現するかをリストで計算 e.g. [0,0,0,4,0]ならas = [3, 3, 3, 3]
      freqList = [(a, 1 :: Int) | a <- as]
      -- Vectorに変換（VU.accumが自動的に同じインデックスを合計）
      freq = dbgId $ VU.accum (+) (VU.replicate (maxA + 2) 0) freqList

      -- k桁目の値はk以上の値が何回登場するかできまる
      -- e.g. as = [3,3,3,3]の場合freqListは[0,0,0,4,0]になるので
      cumsum = dbgId $ VU.scanr' (+) 0 freq
      frozen = cumsum

      -- 桁計算
      -- i
      -- carry: i桁目の繰り上がりの数
      -- acc
      go !i !carry acc
        | i > maxA && carry == 0 = acc
        | otherwise =
            let s =
                  (if i <= maxA then frozen VU.! i else 0)
                    + carry -- 繰り上がりを追加
                digit = s `mod` 10 -- i桁目の数
                carry' = s `div` 10
             in go (i + 1) carry' (digit : acc) -- NOTE: i桁目の結果を先頭に追加していくのでreverse不要
      digits = go 1 0 []
   in -- 先頭から文字列化
      BS.pack $ concatMap show digits

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in solve as <> BS.pack "\n"