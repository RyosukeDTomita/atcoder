-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
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
solve s = foldl' go 0 indexOfC
  where
    indexOfC = dbgId $ BS.elemIndices 'C' s
    sN = dbgId $ BS.length s
    go :: Int -> Int -> Int
    go result i = min i (sN - i - 1) + 1 + result

-- 厳密にカウントするとこれ
-- \| i + 1 <= (sN - (i + 1)) = i + 1 + result
-- \| otherwise = sN - i - 1 + 1 + result
-- 整理したがminを使えばいいことに気がついた
-- \| i + 1 <= (sN - (i + 1)) = i + 1 + result -- C単体を含めるため+1している
-- \| otherwise = sN - i + result -- C単体を含めるため+1している。

main :: IO ()
main =
  BS.interact $ \inputs -> (BS.pack . show) (solve (BS.filter (/= '\n') inputs)) <> BS.pack "\n"
