{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.Map.Strict qualified as Map
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

-- スライディングウィンドウ方式を使う。
-- 1 ≤ i ≤ j ≤ N
-- s[i] = s[j]
-- l ≤ j - i ≤ r
-- つまり、iとjの距離がl〜rかつ同じ文字である際の(i, j)のペアを求める
solve :: Int -> Int -> Int -> BS.ByteString -> Int
solve n l r s = go 0 Map.empty 0
  where
    sv = VU.fromList (BS.unpack s)
    -- 各iに対してs[i]と同じ要素を持つ文字が何個あるかをスライディングウィンドウ方式で求める。
    go :: Int -> Map.Map Char Int -> Int -> Int
    go !acc !ms !i
      | i >= n = acc -- 終了条件
      | otherwise =
          let cnt = Map.findWithDefault 0 (sv VU.! i) ms -- s[i]と同じ文字は何個あるかカウントする
          -- NOTE: l ≤ j - i ≤ r これを変形すると、i - r ≤ j ≤ i - l
          -- windowのサイズ=iを固定したときのjの範囲
              ms' =
                if i + 1 >= l
                  then Map.insertWith (+) (sv VU.! (i + 1 - l)) 1 ms -- 新しい文字を追加する
                  else ms
              -- 古い文字を削除する
              ms'' =
                if i + 1 >= r + 1
                  then
                    let c = sv VU.! (i + 1 - r - 1)
                        newCount = Map.findWithDefault 0 c ms' - 1
                     in if newCount <= 0 then Map.delete c ms' else Map.insert c newCount ms'
                  else ms'
           in go (acc + cnt) ms'' (i + 1)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, l, r] = map readInt . BS.words $ head ls :: [Int]
        s = ls !! 1
     in (BS.pack . show) (solve n l r s) <> BS.pack "\n"
