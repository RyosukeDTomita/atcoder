-- WAになったので全探索する
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad (replicateM)
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
solve ls =
  let ls' = map fromIntegral ls :: [Double]
   in maximum
        [ count 0.5 (zipWith (*) signs ls')
          | signs <- replicateM (length ls') [1, -1]
        ]
  where
    count :: Double -> [Double] -> Int
    count _ [] = 0
    count x (d : ds) =
      let x' = x + d
          c = if (x > 0) /= (x' > 0) then 1 else 0
       in c + count x' ds

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls' = BS.lines inputs
        !n = readInt $ head ls'
        !ls = map readInt . BS.words $ ls' !! 1 :: [Int]
     in BS.pack (show $ solve ls) <> BS.pack "\n"
