-- TLE
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

solve :: [Int] -> [[Int]] -> [Int]
solve as xyS = map go xyS
  where
    go [x, y] =
      let notList = filter (\a -> notElem a as) [x ..]
       in notList !! (y - 1)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, q] = map readInt . BS.words $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
        xyS = map (map readInt . BS.words) $ drop 2 $ ls :: [[Int]]
     in BS.unwords (map (BS.pack . show) (solve as xyS)) <> BS.pack "\n"