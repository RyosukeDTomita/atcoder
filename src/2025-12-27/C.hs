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

-- NOTE: 前提としてデータを消す順番が結果に影響しない。そのため、データは前から順に処理していく
solve :: [Int] -> Int
solve as = length $ go [] as
  where
    go stack [] = stack
    go stack (a : as)
      -- \| length stack >= 3 && all (== a) (take 3 stack) = go (drop 3 stack) as -- TLE対策でlengthするタイミングを変える
      | length (take 3 stack) == 3 && all (== a) (take 3 stack) = go (drop 3 stack) as
      | otherwise = go (a : stack) as

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"