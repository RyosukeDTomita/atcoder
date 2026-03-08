{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
-- import Control.Monad (State)

import Data.List (foldl')
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
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

fst' :: ([Int], [Int], [Int]) -> [Int]
fst' (a, _, _) = a

snd' :: ([Int], [Int], [Int]) -> [Int]
snd' (_, b, _) = b

thd' :: ([Int], [Int], [Int]) -> [Int]
thd' (_, _, c) = c

solve :: [([Int], [Int], [Int])] -> [Int]
solve caseS = map go caseS
  where
    go :: ([Int], [Int], [Int]) -> Int
    go c =
      let ns = fst' c
          as = snd' c
          bs = thd' c
          n = head ns
          d = ns !! 1
       in simulate n d as bs

-- 卵の在庫管理を行う
simulate :: Int -> Int -> [Int] -> [Int] -> Int
simulate n d as bs = VU.length $ foldl' processDay VU.empty (zip3 [1 .. n] as bs)
  where
    -- 卵の賞味期限管理を行うため、Dの配列で卵を管理する。
    processDay :: VU.Vector Int -> (Int, Int, Int) -> VU.Vector Int
    processDay stock (day, a, b) =
      -- 仕入れ: Ai個の卵を追加
      let stock1 = stock VU.++ VU.replicate a d
          -- 使用: Bi個の卵を使用(FIFO)
          stock2 = VU.drop b stock1
          -- 処分
          stock3 = VU.map (\x -> x - 1) stock2
          stock4 = VU.filter (>= 0) stock3 -- NOTE: 問題文にD=2の時、3日目に1日目に仕入れた卵を処分するとあるので<0の卵を処分する
       in stock4

parse :: [BS.ByteString] -> [([Int], [Int], [Int])]
parse [] = []
parse (ndByteS : asByteS : bsByteS : rest) =
  let [n, d] = map readInt . BS.words $ ndByteS :: [Int]
      as = map readInt . BS.words $ asByteS :: [Int]
      bs = map readInt . BS.words $ bsByteS :: [Int]
   in ([n, d], as, bs) : parse rest

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        _ = readInt $ head ls -- T
        caseS = parse $ tail ls
     in BS.unlines (map (BS.pack . show) (solve caseS))
