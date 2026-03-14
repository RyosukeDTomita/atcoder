-- foldl'バージョン
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

solve :: BS.ByteString -> Int
solve s =
  let (_, _, cN) = BS.foldl' step (0, 0, 0) s
   in cN
  where
    {-# INLINE step #-}
    step (!aN, !bN, !cN) b
      | b == 'A' = (aN + 1, bN, cN)
      | b == 'B' = (aN, min aN (bN + 1), cN)
      | b == 'C' = (aN, bN, min bN (cN + 1))
      | otherwise = error "Unexpected Inputs"

main :: IO ()
main =
  -- initで改行削除
  BS.interact $ \s ->
    (BS.pack . show) (solve (BS.init s)) <> BS.pack "\n"
