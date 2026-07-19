{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad (foldM, when)
import Control.Monad.ST (ST, runST)
import Data.ByteString.Char8 qualified as BS
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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- m=2固定の場合
-- b_i == 0 -> (a_i + a_(i+1)) `mod` 2 == 0
-- b_i == 1 -> (a_i + a_(i+1)) `mod` 2 == 1
-- 配列の破壊的更新をしてTLEを回避する
--
-- A_1に足すか否か(x1=0/1)で残りの反転はすべて一意に決まるので、
-- 貪欲を2回(x1=0とx1=1)走らせてminを取る。
solve :: Int -> [Int] -> [Int] -> Int
solve n aList bList = min (run 0) (run 1)
  where
    aijList = zipWith (+) aList $ tail aList
    run :: Int -> Int
    run x1 = runST $ do
      arr <- VU.thaw $ VU.fromList (0 : aijList) -- Vectorは0スタートなので先頭に0を入れている
      VUM.modify arr (+ x1) 1 -- x1=1ならA_1に+1した状態から始める(sum_1に反映)
      foldM (go arr) x1 $ zip [1 ..] bList
    go :: VUM.MVector s Int -> Int -> (Int, Int) -> ST s Int
    go arr cnt (i, b) = do
      v <- VUM.read arr i
      if v `mod` 2 == b
        then pure cnt
        else do
          VUM.modify arr (+ 1) i
          when (i + 1 <= n - 1) $ VUM.modify arr (+ 1) (i + 1)
          pure (cnt + 1)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [n, _m] = map readInt . BS.words $ head ls :: [Int] -- m=2
      aList = map readInt . BS.words $ ls !! 1 :: [Int]
      bList = map readInt . BS.words $ ls !! 2 :: [Int]
   in (BS.pack . show) (solve n aList bList) <> BS.pack "\n"
