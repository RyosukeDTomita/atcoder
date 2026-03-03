-- foldl'バージョン(最適化)
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

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

-- UNPACK付き厳密データ型を使うことでunbox化され、ポインタ関節参照が消えて速くなる。
data S = S {-# UNPACK #-} !Int {-# UNPACK #-} !Int {-# UNPACK #-} !Int

solve :: BS.ByteString -> Int
solve s =
  let S _ _ cN = BS.foldl' step (S 0 0 0) s
   in cN
  where
    step (S aN bN cN) b
      | b == 'A' = S (aN + 1) bN cN
      | b == 'B' = S aN (min aN (bN + 1)) cN
      | b == 'C' = S aN bN (min bN (cN + 1))
      | otherwise = error "Unexpected Inputs"

main :: IO ()
main =
  -- initで改行削除
  BS.interact $ \s ->
    (BS.pack . show) (solve (BS.init s)) <> BS.pack "\n"
