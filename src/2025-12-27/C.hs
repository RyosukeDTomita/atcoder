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
solve as =
  go as []
  where
    go as' as
      | as' == as = length as
      | otherwise = go (go' as) as
    go' (a0 : a1 : a2 : a3 : as)
      | a0 == a1 && a1 == a2 && a2 == a3 = go' as
      | null as = a0 : a1 : a2 : a3 : []
      | otherwise = a0 : go' (a1 : a2 : a3 : as)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"