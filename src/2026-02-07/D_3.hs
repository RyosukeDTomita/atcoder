-- TLE
-- 10^jの計算もメモ化した
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Vector qualified as V
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

-- 10^jを計算する
calJ :: Int -> Integer
calJ j = 10 ^ j

-- メモ化された10^jの結果（グローバル、最大200000まで）
jVec :: V.Vector Integer
jVec = V.generate 200001 calJ

calB :: Int -> Integer
calB a =
  sum
    [ jVec V.! j
      | j <- [0 .. a - 1]
    ]

-- メモ化された計算結果のVector
makeBVector :: Int -> V.Vector Integer
makeBVector maxA = V.generate (maxA + 1) calB

solve :: [Int] -> Integer
solve as =
  let maxA = maximum as
      bVec = makeBVector maxA
   in sum $ map (bVec V.!) as

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve as) <> BS.pack "\n"