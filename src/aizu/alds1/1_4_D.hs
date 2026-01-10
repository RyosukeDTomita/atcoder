{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
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

solve :: [Int] -> Int
solve ws = head ws

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- [n, k] = map readInt . BS.words $ head ls :: [Int]
        ws = map readInt $ tail ls :: [Int]
     in (BS.pack . show) (solve ws) <> BS.pack "\n"