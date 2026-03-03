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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: BS.ByteString -> Int
solve s = loop (0, 0, 0) s
  where
    -- BangPatternsで正格評価にしたら速くなった。 54 ms -> 10 ms
    loop (!aN, !bN, !cN) bs = case BS.uncons bs of
      Nothing -> cN
      Just (b, rest)
        | b == 'A' -> loop (aN + 1, bN, cN) rest
        | b == 'B' ->
            let bN' = min aN (bN + 1)
             in loop (aN, bN', cN) rest
        | b == 'C' ->
            let cN' = min bN (cN + 1)
             in loop (aN, bN, cN') rest
        | otherwise -> error "Unexpected Inputs"

main :: IO ()
main =
  -- initで改行削除
  BS.interact $ \s ->
    (BS.pack . show) (solve (BS.init s)) <> BS.pack "\n"
