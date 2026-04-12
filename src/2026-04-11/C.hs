-- 貪欲法で0に近づくようにしてみたがWAになった。
{-# LANGUAGE BangPatterns #-}
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: [Int] -> Int
solve ls =
  let ls' = map fromIntegral ls :: [Double]
   in snd $ foldl' go (0.5, 0) ls' :: Int
  where
    go :: (Double, Int) -> Double -> (Double, Int)
    go (x, i) l
      | x > 0 =
          let x' = x - l
           in if x' < 0 then (x', i + 1) else (x', i)
      | otherwise =
          let x' = x + l
           in if x' > 0 then (x', i + 1) else (x', i)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls' = BS.lines inputs
        !n = readInt $ head ls'
        !ls = map readInt . BS.words $ ls' !! 1 :: [Int]
     in BS.pack (show $ solve ls) <> BS.pack "\n"
